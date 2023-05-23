import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:new_spark/widgets/custom_snackbar.dart';

// const String jwtToken =
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkYWUyZDBiZC0zMGZhLTQ0YjMtYjJhNS02OTU0NmE3ZGU4YmUiLCJlbWFpbCI6ImFucHJhbW9keWFAZ21haWwuY29tIiwiaWF0IjoxNjgxNTkyMTY1LCJleHAiOjE2ODE2MzUzNjV9.nte_Z0UWXoLzQcdYTI_xuGy-L8jNa3eNfRJpZ3CF3i4';
const String baseUrl = 'http://192.168.8.100:3333/';
const String socketUrl = 'http://192.168.8.100:3333';
//const String baseUrl = 'http://10.54.85.125:3333/';
//const String socketUrl = 'http://10.54.85.125:3333';
//const String baseUrl = 'http://localhost:3333/';
//const String socketUrl = 'http://localhost:3333';

class Authentication {
  var client = http.Client();

  Future<dynamic> get(String api, BuildContext context) async {
    try {
      var url = Uri.parse(baseUrl + api);
      //var _headers = {'Authorization': 'Bearer jwtToken'};
      var response = await client.get(
        url,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception();
      }
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
    }
  }

  Future<dynamic> post(String api, dynamic object, BuildContext context) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var _payload = json.encode(object);
      var _headers = {
        'Authorization': 'Bearer jwtToken',
        'Content-Type': 'application/json'
      };
      var response = await client.post(url, body: _payload, headers: _headers);
      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        print('bad request');
        //throw exception
      }
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
    }
  }

  Future<int> signin(
      String uniEmail, String password, BuildContext context) async {
    try {
      var api = 'auth/signin';
      var url = Uri.parse(baseUrl + api);
      var response = await http
          .post(url, body: {"uniEmail": uniEmail, "password": password});

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        var accessToken = responseBody['access_token'];
        print(accessToken);
        saveAccessToken(accessToken);
        return response.statusCode;
      } else {
        throw Exception();
      }
    } catch (e) {
      showErrorSnackbar(context, 'Wrong Credentials! Try again');
      return 404;
    }
  }

  void saveAccessToken(String accessToken) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'accessToken', value: accessToken);
  }

  Future<String?> getAccessToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'accessToken');
  }

  void deleteAccessToken() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'accessToken');
    print('deleted accessToken');
  }

  logout(BuildContext context) async {
    try {
      var token = await getAccessToken();
      var api = 'auth/signout';
      var url = Uri.parse(baseUrl + api);
      var response =
          await http.post(url, headers: {'Authorization': 'Bearer $token'});
      deleteAccessToken();
      if (response.statusCode != 201) {
        throw Exception();
      }
    } catch (e) {
      showErrorSnackbar(context, 'Logging out failed!');
    }
  }

  Future<bool> isAuthorized() async {
    String? jwtToken = await getAccessToken();
    if (jwtToken == null || jwtToken.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  // Future<int> signinWeb(
  //     String uniEmail, String password, BuildContext context) async {
  //   try {
  //     var api = 'auth/signin';
  //     var url = Uri.parse(baseUrl + api);
  //     var response = await http
  //         .post(url, body: {"uniEmail": uniEmail, "password": password});

  //     if (response.statusCode == 200) {
  //       var responseBody = json.decode(response.body);
  //       var accessToken = responseBody['access_token'];
  //       print(accessToken);
  //       saveCookieJwt(accessToken);
  //       return response.statusCode;
  //     } else {
  //       throw Exception();
  //     }
  //   } catch (e) {
  //     showErrorSnackbar(context, 'Wrong Credentials! Try again');
  //     return 404;
  //   }
  // }

  // void saveCookieJwt(String accessToken) async {
  //   var api = 'auth/signin';
  //   var cookieJar = CookieJar();
  //   var cookie = Cookie('jwt_token', accessToken);
  //   cookieJar.saveFromResponse(Uri.parse(baseUrl + api), [cookie]);
  // }

  // void getCookieJwt() async {
  //   var api = 'auth/signin';
  //   var cookieJar = CookieJar();
  //   List<Cookie> cookies =
  //       await cookieJar.loadForRequest(Uri.parse(baseUrl + api));
  //   String jwtToken;
  //   for (Cookie cookie in cookies) {
  //     if (cookie.name == 'jwt_token') {
  //       jwtToken = cookie.value;
  //       print(jwtToken);
  //       break;
  //     }
  //   }
  // }

  Future<int> signUp(
      BuildContext context,
      String username,
      String password,
      String uniEmail,
      String firstName,
      String lastName,
      String university,
      String faculty,
      String isOnline) async {
    try {
      var api = 'auth/signup';
      var url = Uri.parse(baseUrl + api);
      var response = await http.post(url, body: {
        "username": username,
        "password": password,
        "uniEmail": uniEmail,
        "firstName": firstName,
        "lastName": lastName,
        'university': university,
        'faculty': faculty,
        'isOnline': isOnline
      });
      if (response.statusCode == 201) {
        var responseBody = json.decode(response.body);
        var accessToken = responseBody['access_token'];
        print(accessToken);
        //logging in after signup
        saveAccessToken(accessToken);
        return response.statusCode;
      } else if (response.statusCode == 403) {
        return response.statusCode;
      } else {
        throw Exception();
      }
    } catch (e) {
      showErrorSnackbar(context, 'Signup Failed');
      return 404;
    }
  }
}
