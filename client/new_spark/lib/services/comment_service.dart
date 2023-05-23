import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_spark/services/authentication.dart';
import 'package:new_spark/widgets/custom_snackbar.dart';
import '../models/comment_model.dart';

class CommentService {
  Future<List<Comment>> getComments(id, BuildContext context) async {
    try {
      //var id = 2;
      var api = 'post/comment/$id';
      var url = Uri.parse(baseUrl + api);
      print(url);

      final response = await http.get(url);
      print("response returned");
      final body = json.decode(response.body);
      print("response body");
      print(body);

      return body.map<Comment>(Comment.fromJson).toList();
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
      return [];
    }
  }

  Stream<List<Comment>> getCommentsStream(id, BuildContext context) {
    try {
      //var id = 2;
      var api = 'post/comment/$id';
      var url = Uri.parse(baseUrl + api);
      print(url);

      // final response = await http.get(url);
      return http.get(url).asStream().map((response) {
        print("response returned");
        final body = json.decode(response.body);
        print("response body");
        print(body);

        return body.map<Comment>(Comment.fromJson).toList();
      });
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong');
      return Stream.value([]);
    }
  }

  postComment(String commentText, String postId, BuildContext context) async {
    try {
      var token = await Authentication().getAccessToken();

//currentUser comes from another method and executes inside the postComment method

      var api = 'post/comment';
      var url = Uri.parse(baseUrl + api);
      var response = await http.post(url,
          body: {"postId": postId, "comment": commentText},
          headers: {'Authorization': 'Bearer $token'});
      print(response.body);
    } catch (e) {
      showErrorSnackbar(context, "Something went wrong!");
    }
  }
}
