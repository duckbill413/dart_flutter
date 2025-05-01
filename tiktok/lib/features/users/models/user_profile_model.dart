class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String username;
  final String birthday;
  final String bio;
  final String link;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.username,
    required this.bio,
    required this.link,
    required this.birthday,
  });

  UserProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        username = '',
        birthday = '',
        bio = '',
        link = '';

  Map<String, String> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'nickname': username,
      'birthday': birthday,
      'bio': bio,
      'link': link,
    };
  }

  UserProfileModel.fromMap(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'],
        username = json['nickname'],
        birthday = json['birthday'],
        bio = json['bio'],
        link = json['link'];
}
