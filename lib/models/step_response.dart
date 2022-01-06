// To parse this JSON data, do
//
//     final stepsResponse = stepsResponseFromJson(jsonString);

import 'dart:convert';

List<StepsResponse> stepsResponseFromJson(String str) => List<StepsResponse>.from(json.decode(str).map((x) => StepsResponse.fromJson(x)));

String stepsResponseToJson(List<StepsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StepsResponse {
  StepsResponse({
    this.stepid,
    this.stepname,
    this.stepsymbol,
    this.videolink,
  });

  String? stepid;
  String? stepname;
  String? stepsymbol;
  String? videolink;

  factory StepsResponse.fromJson(Map<String, dynamic> json) => StepsResponse(
    stepid: json["stepid"],
    stepname: json["stepname"],
    stepsymbol: json["stepsymbol"],
    videolink: json["videolink"],
  );

  Map<String, dynamic> toJson() => {
    "stepid": stepid,
    "stepname": stepname,
    "stepsymbol": stepsymbol,
    "videolink": videolink,
  };
}
