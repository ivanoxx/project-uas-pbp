// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);

import 'dart:convert';

List<Forum> forumFromJson(String str) => List<Forum>.from(json.decode(str).map((x) => Forum.fromJson(x)));

String forumToJson(List<Forum> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forum {
  Forum({
    required this.model,
    required this.pk,
    required this.fields,
  });

  Model model;
  int pk;
  Fields fields;

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
    model: modelValues.map[json["model"]]!,
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": modelValues.reverse[model],
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  Fields({
    required this.creator,
    required this.title,
    required this.description,
    required this.dateCreated,
    required this.contents,
  });

  int creator;
  String title;
  String description;
  DateTime dateCreated;
  List<int> contents;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    creator: json["creator"],
    title: json["title"],
    description: json["description"],
    dateCreated: DateTime.parse(json["date_created"]),
    contents: List<int>.from(json["contents"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "creator": creator,
    "title": title,
    "description": description,
    "date_created": dateCreated.toIso8601String(),
    "contents": List<dynamic>.from(contents.map((x) => x)),
  };
}

enum Model { FORUM_FORUM }

final modelValues = EnumValues({
  "forum.forum": Model.FORUM_FORUM
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
