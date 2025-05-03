class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String username;
  final String birthday;
  final String bio;
  final String link;
  final String? avatarLink;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.username,
    required this.bio,
    required this.link,
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

  Map<String, String> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'nickname': username,
      'birthday': birthday,
      'bio': bio,
      'link': link,
      'avatarLink': avatarLink ?? '',
    };
  }

  UserProfileModel.fromMap(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'],
        username = json['nickname'],
        birthday = json['birthday'],
        bio = json['bio'],
        link = json['link'],
        avatarLink = json['avatarLink'];

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? username,
    String? birthday,
    String? bio,
    String? link,
    String? avatarLink,
  }) =>
      UserProfileModel(
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
