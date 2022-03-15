class PhotoList {
  PhotoList({
    required this.id,
    required this.createdAt,
    required this.width,
    required this.height,
    required this.color,
    required this.urls,
    required this.likes,
  });

  String id;
  String createdAt;
  int width;
  int height;
  String color;
  Urls urls;
  int likes;

  factory PhotoList.fromJson(Map<String, dynamic> json) => PhotoList(
    id: json["id"],
    createdAt: json["created_at"],
    width: json["width"],
    height: json["height"],
    color: json["color"],
    urls: Urls.fromJson(json["urls"]),
    likes: json["likes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "width": width,
    "height": height,
    "color": color,
    "urls": urls.toJson(),
    "likes": likes,
  };
}

class Urls {
  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String smallS3;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    raw: json["raw"],
    full: json["full"],
    regular: json["regular"],
    small: json["small"],
    thumb: json["thumb"],
    smallS3: json["small_s3"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "full": full,
    "regular": regular,
    "small": small,
    "thumb": thumb,
    "small_s3": smallS3,
  };
}
