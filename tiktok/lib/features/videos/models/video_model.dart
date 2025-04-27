import 'package:uuid/uuid.dart';

class VideoModel {
  String id = Uuid().v4();
  String title;

  String contentPath;

  VideoModel({
    required this.title,
    required this.contentPath,
  });
}
