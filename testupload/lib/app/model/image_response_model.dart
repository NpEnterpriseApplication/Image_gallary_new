import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';

ImageResponseModel imageResponseModelFromJson(String str) => ImageResponseModel.fromJson(json.decode(str));

String imageResponseModelToJson(ImageResponseModel data) => json.encode(data.toJson());

class ImageResponseModel {
  int? total;
  int? totalHits;
  List<Hit>? hits;

  ImageResponseModel({
    this.total,
    this.totalHits,
    this.hits,
  });

  factory ImageResponseModel.fromJson(Map<String, dynamic> json) => ImageResponseModel(
    total: json["total"],
    totalHits: json["totalHits"],
    hits: json["hits"] == null
        ? []
        : List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "totalHits": totalHits,
    "hits": hits == null
        ? []
        : List<dynamic>.from(hits!.map((x) => x.toJson())),
  };
}

class Hit {
  int? id;
  String? pageUrl;
  String? type;
  String? tags;
  String? previewUrl;
  int? previewWidth;
  int? previewHeight;
  String? webformatUrl;
  int? webformatWidth;
  int? webformatHeight;
  String? largeImageUrl;
  int? imageWidth;
  int? imageHeight;
  int? imageSize;
  int? views;
  int? downloads;
  int? collections;
  int? likes;
  int? comments;
  int? userId;
  String? user;
  String? userImageUrl;
  RxBool isLiked;

  Hit({
    this.id,
    this.pageUrl,
    this.type,
    this.tags,
    this.previewUrl,
    this.previewWidth,
    this.previewHeight,
    this.webformatUrl,
    this.webformatWidth,
    this.webformatHeight,
    this.largeImageUrl,
    this.imageWidth,
    this.imageHeight,
    this.imageSize,
    this.views,
    this.downloads,
    this.collections,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageUrl,
    bool isLiked =false,
  }):isLiked = RxBool(isLiked);

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
    id: json["id"],
    pageUrl: json["pageURL"],
    type: json["type"],
    tags: json["tags"],
    previewUrl: json["previewURL"],
    previewWidth: json["previewWidth"],
    previewHeight: json["previewHeight"],
    webformatUrl: json["webformatURL"],
    webformatWidth: json["webformatWidth"],
    webformatHeight: json["webformatHeight"],
    largeImageUrl: json["largeImageURL"],
    imageWidth: json["imageWidth"],
    imageHeight: json["imageHeight"],
    imageSize: json["imageSize"],
    views: json["views"],
    downloads: json["downloads"],
    collections: json["collections"],
    likes: json["likes"],
    comments: json["comments"],
    userId: json["user_id"],
    user: json["user"],
    userImageUrl: json["userImageURL"],
    isLiked: json['isLiked'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pageURL": pageUrl,
    "type": type,
    "tags": tags,
    "previewURL": previewUrl,
    "previewWidth": previewWidth,
    "previewHeight": previewHeight,
    "webformatURL": webformatUrl,
    "webformatWidth": webformatWidth,
    "webformatHeight": webformatHeight,
    "largeImageURL": largeImageUrl,
    "imageWidth": imageWidth,
    "imageHeight": imageHeight,
    "imageSize": imageSize,
    "views": views,
    "downloads": downloads,
    "collections": collections,
    "likes": likes,
    "comments": comments,
    "user_id": userId,
    "user": user,
    "userImageURL": userImageUrl,
    'isLiked': isLiked,
  };
}
