// To parse this JSON data, do
//
//     final qoute = qouteFromJson(jsonString);

import 'dart:convert';

List<Qoute> qouteFromJson(String str) =>
    List<Qoute>.from(json.decode(str).map((x) => Qoute.fromJson(x)));

String qouteToJson(List<Qoute> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Qoute {
  Qoute({
    this.uuid,
    this.qoute,
  });

  String uuid;
  List<QouteElement> qoute;

  factory Qoute.fromJson(Map<String, dynamic> json) => Qoute(
        uuid: json["uuid"],
        qoute: List<QouteElement>.from(
            json["qoute"].map((x) => QouteElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "qoute": List<dynamic>.from(qoute.map((x) => x.toJson())),
      };
}

class QouteElement {
  QouteElement({
    this.title,
  });

  String title;

  factory QouteElement.fromJson(Map<String, dynamic> json) => QouteElement(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}
