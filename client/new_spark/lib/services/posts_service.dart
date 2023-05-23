import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_spark/models/user_server.dart';
import 'package:new_spark/services/authentication.dart';
import 'package:new_spark/widgets/custom_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/models.dart';
import 'image_upload_service.dart';

class PostService {
  Future<List<Posts>> getPost(BuildContext context) async {
//    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    try {
      var userId = 'dae2d0bd-30fa-44b3-b2a5-69546a7de8be';
      var api = 'post/$userId';
      var url = Uri.parse(baseUrl + api);
      //var url = Uri.parse('http://192.168.1.3:3333/post');
//http://10.20.197.63:3333/post
      final response = await http.get(url);
      final body = json.decode(response.body);
      return body.map<Posts>(Posts.fromJson).toList();
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
      return [];
    }
  }

  static publishPost(String caption, String visibility, String groupId,
      File? image, String imageApi, BuildContext context) async {
    try {
      String postImg =
          await ImageUploadService.uploadImage(imageApi, image, context);

      var api = 'post/create';
      var url = Uri.parse(baseUrl + api);
      var response = await http.post(url, body: {
        "caption": caption,
        "postImg": postImg,
        "visibility": visibility,
        "groupId": groupId
      });
      print(response.body);
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
    }
  }

  likeUnlikePost(String postId, BuildContext context) async {
    try {
      String? token = await Authentication().getAccessToken();
      var api = 'post/like';
      var url = Uri.parse(baseUrl + api);
      var response = await http.post(url,
          body: {"postId": postId},
          headers: {'Authorization': 'Bearer $token'});
      print(response.statusCode);
      return response.statusCode;
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
    }
  }

  sharePost(String postImage, String caption, BuildContext context) async {
    try {
      final urlImage = postImage;
      final url = Uri.parse(urlImage);
      final response = await http.get(url);
      final bytes = response.bodyBytes;
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/image.png';
      File(path).writeAsBytesSync(bytes);

      // await Share.share("text");
      await Share.shareFiles([path], text: caption);
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong');
    }
  }

  Future<List<LikedUsers>> getAllLikes(
      String postId, BuildContext context) async {
    try {
      var api = 'post/likes/$postId';
      var url = Uri.parse(baseUrl + api);
      var response = await http.get(url);
      final body = json.decode(response.body);
      return body.map<LikedUsers>(LikedUsers.fromJson).toList();
    } catch (e) {
      showErrorSnackbar(context, 'Something went wrong!');
      return [];
    }
  }
//   uploadPostImage(File? image) async {
//     var api = 'post/image';
//     var url = Uri.parse(baseUrl + api);
//     var request = http.MultipartRequest('POST', url);

//     var stream = new http.ByteStream(image.)
//     stream.cast();

//     var length = await image!.length();

//     var multipart = new http.MultipartFile('filename', stream, length);
//     request.files.add(multipart);
//     var response = await request.send();

//     if (response.statusCode == 200) {
//       print(response.stream);
//     } else {
//       print("Failed");
//     }
// //    request.files.add(http.MultipartFile('filename'));
//   }
}
