class WebtoonModel {
  String id;
  String title;
  String thumb;
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
