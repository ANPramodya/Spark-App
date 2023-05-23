import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_spark/services/authentication.dart';

import 'package:http/http.dart' as http;
import 'package:new_spark/services/image_upload_service.dart';
import 'package:new_spark/widgets/custom_snackbar.dart';

import '../models/user_server.dart';

class UserService {
  Future<List<Users>> getUser(BuildContext context) async {
//    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    //var url = Uri.parse('http://10.20.197.173:3333/users');

    try {
      var jwtToken = await Authentication().getAccessToken();
      var api = 'users';
      var url = Uri.parse(baseUrl + api);
      //http://10.20.197.63:3333/users
      final response =
          await http.get(url, headers: {"Authorization": "Bearer $jwtToken"});
      final body = json.decode(response.body);
      return body.map<Users>(Users.fromJson).toList();
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
      return [];
    }
  }

//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkYWUyZDBiZC0zMGZhLTQ0YjMtYjJhNS02OTU0NmE3ZGU4YmUiLCJlbWFpbCI6ImFucHJhbW9keWFAZ21haWwuY29tIiwiaWF0IjoxNjgxMzY3NTI0LCJleHAiOjE2ODE0MTA3MjR9.KlQArPKjV3y68CdDZBmSyHTsiRtoOKx5rTtQhml9HfU

  Future<Users> getMe(BuildContext context) async {
    // try {
    var jwtToken = await Authentication().getAccessToken();

    var api = 'users/me';
    var url = Uri.parse(baseUrl + api);
    final response =
        await http.get(url, headers: {"Authorization": "Bearer $jwtToken"});
    final body = json.decode(response.body);
    return Users.fromJson(body);
    // } catch (e) {
    //   showErrorSnackbar(context, 'Something went wrong!');
    //   throw Exception('Failed to get user data');
    // }
  }

  static editProfilePic(
      File? image, String imageApi, String userId, BuildContext context) async {
    try {
      var jwtToken = await Authentication().getAccessToken();
      String profilePic =
          await ImageUploadService.uploadImage(imageApi, image, context);
      //imageApi is for the upload endpoint
      //this api for editting databse endpoint
      var api = 'users/updateProfilePic/$userId';
      var url = Uri.parse(baseUrl + api);
      var response = await http.patch(url,
          body: {"imageUrl": profilePic},
          headers: {"Authorization": "Bearer $jwtToken"});
      print(response.body);
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
    }
  }

  static editCoverPhoto(
      File? image, String imageApi, String userId, BuildContext context) async {
    try {
      var jwtToken = await Authentication().getAccessToken();
      String profilePic =
          await ImageUploadService.uploadImage(imageApi, image, context);
      var api = 'users/updateCoverPhoto/$userId';
      var url = Uri.parse(baseUrl + api);
      var response = await http.patch(url,
          body: {"imageUrl": profilePic},
          headers: {"Authorization": "Bearer $jwtToken"});
      print(response.body);
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
    }
  }
}
