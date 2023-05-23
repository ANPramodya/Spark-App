import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_spark/models/user_server.dart';
import 'package:new_spark/services/authentication.dart';
import 'package:new_spark/services/image_upload_service.dart';
import 'package:new_spark/widgets/custom_snackbar.dart';

import '../models/models.dart';

class GroupService {
  Future<List<Group>> getGroups(BuildContext context) async {
    try {
      var api = 'group';
      var url = Uri.parse(baseUrl + api);
      final response = await http.get(url);
      final body = json.decode(response.body);
      return body.map<Group>(Group.fromJson).toList();
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
      return [];
    }
  }

//http://10.20.197.63:3333/group
  Future<List<UsersOnGroups>> getGroup(
      String groupId, BuildContext context) async {
    try {
      var url = Uri.parse(baseUrl + 'group/$groupId');
      final response = await http.get(url);
      final body = json.decode(response.body);
      return body.map<UsersOnGroups>(UsersOnGroups.fromJson).toList();
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong');
      return [];
    }
  }

  createGroup(String groupName, String groupDescription, File? image,
      BuildContext context) async {
    try {
      String imageUrl =
          await ImageUploadService.uploadImage('post/image', image, context);
      String? token = await Authentication().getAccessToken();

      var api = 'group/create';
      var url = Uri.parse(baseUrl + api);
      var response = await http.post(url, body: {
        "groupName": groupName,
        "groupImage": imageUrl,
        "groupDescription": groupDescription
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      print(response.body);
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
    }
  }

  Future<List<Posts>> getGroupPosts(
      String groupId, BuildContext context) async {
    try {
      var url = Uri.parse(baseUrl + 'group/posts/$groupId');
      final response = await http.get(url);
      final body = json.decode(response.body);
      return body.map<Posts>(Posts.fromGroupJson).toList();
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong');
      return [];
    }
  }

  Future<List<Users>?> searchUsers(
      String searchTerm, BuildContext context) async {
    var jwtToken = await Authentication().getAccessToken();
    var url = Uri.parse(baseUrl + 'users/search?q=Ni');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $jwtToken'});

    final body = json.decode(response.body);
    print(body);
    //return null;
    return body.map<Users>(Users.fromJson(body)).toList();
    // try {

    // } catch (e) {
    //   showErrorSnackbar(context, 'Something went wrong!');
    // }
  }
}
