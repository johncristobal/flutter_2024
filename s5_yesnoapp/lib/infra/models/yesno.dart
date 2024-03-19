// To parse this JSON data, do
//
//     final yesNoResponse = yesNoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:s5_yesnoapp/domain/entities/message.dart';

YesNoResponse yesNoResponseFromJson(String str) => YesNoResponse.fromJson(json.decode(str));

String yesNoResponseToJson(YesNoResponse data) => json.encode(data.toJson());

class YesNoResponse {
    String answer;
    bool forced;
    String image;

    YesNoResponse({
        required this.answer,
        required this.forced,
        required this.image,
    });

    factory YesNoResponse.fromJson(Map<String, dynamic> json) => YesNoResponse(
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
    };

    Message toMessageEntity() => Message(
      text: answer == "yes" ? "Si" : "No", from: From.hers, imageUrl: image);
}
