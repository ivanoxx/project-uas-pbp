// To parse this JSON data, do
//
//     final comnment = comnmentFromJson(jsonString);

import 'dart:convert';

List<Comment> comnmentFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String comnmentToJson(List<Comment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
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
    required this.user,
    required this.dateCreated,
    required this.comment,
    required this.commentedOn,
  });

  int user;
  DateTime dateCreated;
  String comment;
  int commentedOn;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    dateCreated: DateTime.parse(json["date_created"]),
    comment: json["comment"],
    commentedOn: json["commented_on"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "date_created": "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
    "comment": comment,
    "commented_on": commentedOn,
  };
}
