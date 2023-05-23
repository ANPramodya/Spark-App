import 'dart:convert';

import '../models/message_server.dart';
import 'package:http/http.dart' as http;

class MessageService {
  Future<List<Messages>> getMessage() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);
    final body = json.decode(response.body);
    return body.map<Messages>(Messages.fromJson).toList();
  }
}
