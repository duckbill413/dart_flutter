import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String id;
  final String title;
  final String description;
  final String contentPath;
  final String thumbnailPath;
  final int likes;
  final int comments;
  final List<String> tags;
  final String creatorUid;
  final DateTime createdAt;
  final String creator;

  const VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.contentPath,
    required this.thumbnailPath,
    required this.likes,
    required this.comments,
    required this.tags,
    required this.creatorUid,
    required this.createdAt,
    required this.creator,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'contentPath': this.contentPath,
      'thumbnailPath': this.thumbnailPath,
      'likes': this.likes,
      'comments': this.comments,
      'tags': this.tags,
      'creatorUid': this.creatorUid,
      'createdAt': this.createdAt,
      'creator': this.creator,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      contentPath: map['contentPath'] as String,
      thumbnailPath: map['thumbnailPath'] as String,
      likes: map['likes'] as int,
      comments: map['comments'] as int,
      tags: List<String>.from(map['tags'] ?? []),
      creatorUid: map['creatorUid'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      creator: map['creator'] as String,
    );
  }

  @override
  String toString() {
    return 'VideoModel{id: $id, title: $title, description: $description, contentPath: $contentPath, thumbnailPath: $thumbnailPath, likes: $likes, comments: $comments, tags: $tags, creatorUid: $creatorUid, createdAt: $createdAt, creator: $creator}\n';
  }
}
