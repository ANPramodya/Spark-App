import 'package:new_spark/models/user_server.dart';

class Story {
  final Users user;
  final String imageUrl;
  final bool isViewed;

  const Story({
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });
}
