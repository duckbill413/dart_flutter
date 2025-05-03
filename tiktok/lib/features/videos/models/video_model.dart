class VideoModel {
  final String id;
  final String title;
  final String description;
  final String contentPath;
  final String thumbnailPath;
  final int likes;
  final int comments;
  final String creatorUid;
  final int createdAt;

  final String creator;

  const VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.contentPath,
    required this.thumbnailPath,
    required this.likes,
    required this.comments,
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
      creatorUid: map['creatorUid'] as String,
      createdAt: map['createdAt'] as int,
      creator: map['creator'] as String,
    );
  }
}
