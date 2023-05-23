import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_spark/models/user_server.dart';
import 'package:new_spark/services/authentication.dart';

class ChatUsers {
  var client = http.Client();

  Future<List<Users>> getUsers(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _header = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjMDY2ZWIzOS00MTZmLTQyNzctOTgyZS0wZGZhMzhmZTRjNGEiLCJlbWFpbCI6ImthdmluZGFAZ21haWwuY29tIiwiaWF0IjoxNjcyNDY3NjM4LCJleHAiOjE2NzI0Njg1Mzh9.zA0lBkDBxVjfPD1RQej7gHUqLgswIbeMmrW2aTZdt8w'
    };
    //var _headers = {'Authorization': 'Bearer jwtToken'};
    var response = await client.get(url, headers: _header);
    final body = json.decode(response.body);
    return body.map<Users>(Users.fromJson).toList();
    // if (response.statusCode == 200) {
    //   return response.body;
    // } else {
    //   //throw exception
    // }
  }
}
