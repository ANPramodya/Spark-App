import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_spark/services/group_service.dart';
//import 'package:new_spark/services/group_service.dart';

import '../models/user_server.dart';
import '../widgets/profile_avatar.dart';

class AddMemberScreen extends StatefulWidget {
  
  final String groupId;

  const AddMemberScreen({super.key, required this.groupId});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  List<Users> searchResults = [];

  final _searchController = TextEditingController();

  //reduce API calls by debounce
  Timer? _debounce;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    if (_searchController.text.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }

  //send API calls per very 1500ms when textfield changes
    _debounce = Timer(const Duration(milliseconds: 1500), () async {
      print(_searchController.text);
      final searchTerm = _searchController.text;
      final results = await GroupService().searchUsers(searchTerm, context);
      setState(() {
        searchResults = results!;
      });
      //searchUserFuture = GroupService().searchUsers(searchTerm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
         
//search box
          TextField(
            controller: _searchController,
            onChanged: (_) => _onSearchChanged(),
            decoration: InputDecoration(hintText: 'Search'),
          ),
          const SizedBox(
            height: 30.0,
          ),
          //searched users
          FutureBuilder<List<Users>?>(
              future:
                  GroupService().searchUsers(_searchController.text, context),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.hasError}');
                } else if (snapshot.hasData) {
                  final users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text(user.firstName),
                        subtitle: Text(user.lastName),
                        onTap: () {},
                      );
                    },
                  );
                } else {
                  return Text('No Data');
                }
              }))
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
    );
  }
}

//searched users view
Widget _userCard(List<Users> users) => ListView.builder(
    itemCount: users.length,
    itemBuilder: ((context, index) {
      final Users user = users[index];
      return InkWell(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileAvatar(
                imageUrl:
                    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                size: 30.0),
            const SizedBox(
              width: 6.0,
            ),
            Text(user.firstName, style: const TextStyle(fontSize: 16.0))
          ],
        ),
      );
    }));
