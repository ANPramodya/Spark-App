import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:new_spark/services/services.dart';
import 'package:new_spark/widgets/custom_snackbar.dart';

Dio dio = Dio();

class ImageUploadService {
  static uploadImage(String api, File? image, BuildContext context) async {
    try {
      var jwtToken = await Authentication().getAccessToken();
      String filename = image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'filename': await MultipartFile.fromFile(image.path,
            filename: filename, contentType: MediaType('image', 'png')),
      });
      Response response = await dio.post(baseUrl + api,
          data: formData,
          options: Options(headers: {
            'accept': '*/*',
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $jwtToken'
          }));
      print(response.statusCode);
      print(response.data);
      return response.data;
    } catch (e) {
      showErrorSnackbar(context, 'Image upload failed!');
    }
  }
}
