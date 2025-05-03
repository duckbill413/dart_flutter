class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String username;
  final String birthday;
  final String? bio;
  final String? link;
  final String? avatarLink;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.username,
    this.bio,
    this.link,
    required this.birthday,
    this.avatarLink,
  });

  UserProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        username = '',
        birthday = '',
        bio = '',
        link = '',
        avatarLink = null;

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'name': this.name,
      'username': this.username,
      'birthday': this.birthday,
      'bio': this.bio,
      'link': this.link,
      'avatarLink': this.avatarLink,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      username: map['username'] as String,
      birthday: map['birthday'] as String,
      bio: map['bio'] as String?,
      link: map['link'] as String?,
      avatarLink: map['avatarLink'] as String?,
    );
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? username,
    String? birthday,
    String? bio,
    String? link,
    String? avatarLink,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      username: username ?? this.username,
      birthday: birthday ?? this.birthday,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      avatarLink: avatarLink ?? this.avatarLink,
    );
  }
}
