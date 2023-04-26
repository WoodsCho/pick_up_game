class PUser {
  String? uid;
  String? nickname;
  String? thumbnail;
  String? decription;

  PUser({this.uid, this.nickname, this.thumbnail, this.decription});

  factory PUser.fromJson(Map<String, dynamic> json) {
    return PUser(
        uid: json['uid'] == null ? '' : json['uid'] as String,
        nickname: json['nickname'] == null ? '' : json['nickname'] as String,
        thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
        decription:
            json['decription'] == null ? '' : json['decription'] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickname': nickname,
      'thumbnail': thumbnail,
      'decription': decription
    };
  }
}
