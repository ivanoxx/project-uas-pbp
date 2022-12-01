// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.creator,
    required this.title,
    required this.description,
    required this.isCaptured,
    required this.dateCreated,
    this.dateCaptured,
    required this.photo,
    required this.upvoteCount,
  });

  int creator;
  String title;
  String description;
  bool isCaptured;
  DateTime dateCreated;
  dynamic dateCaptured;
  String photo;
  int upvoteCount;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        creator: json["creator"],
        title: json["title"],
        description: json["description"],
        isCaptured: json["is_captured"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCaptured: json["date_captured"],
        photo: json["photo"],
        upvoteCount: json["upvote_count"],
      );

  Map<String, dynamic> toJson() => {
        "creator": creator,
        "title": title,
        "description": description,
        "is_captured": isCaptured,
        "date_created": dateCreated.toIso8601String(),
        "date_captured": dateCaptured,
        "photo": photo,
        "upvote_count": upvoteCount,
      };
}
