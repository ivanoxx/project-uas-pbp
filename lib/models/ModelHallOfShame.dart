// To parse this JSON data, do
//
//     final hallOfShame = hallOfShameFromJson(jsonString);

import 'dart:convert';

List<HallOfShame> hallOfShameFromJson(String str) => List<HallOfShame>.from(json.decode(str).map((x) => HallOfShame.fromJson(x)));

String hallOfShameToJson(List<HallOfShame> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HallOfShame {
    HallOfShame({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory HallOfShame.fromJson(Map<String, dynamic> json) => HallOfShame(
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
        required this.name,
        required this.arrestedDate,
        required this.corruptionType,
        required this.description,
        required this.createdDate,
    });

    String name;
    String arrestedDate;
    String corruptionType;
    String description;
    DateTime createdDate;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        arrestedDate: json["arrested_date"],
        corruptionType: json["corruption_type"],
        description: json["description"],
        createdDate: DateTime.parse(json["created_date"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "arrested_date": arrestedDate,
        "corruption_type": corruptionType,
        "description": description,
        "created_date": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
    };
}
