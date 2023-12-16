/// id : "758150"
/// title : "���п뺴"
/// thumb : "https://image-comic.pstatic.net/webtoon/758150/thumbnail/thumbnail_IMAG21_4135492154714961716.jpg"

class WebtoonModel {
  String id;
  String title;
  String thumb;
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
