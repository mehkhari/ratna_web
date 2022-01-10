// To parse this JSON data, do
//
//     final sequenceResponseList = sequenceResponseListFromJson(jsonString);

import 'dart:convert';

List<SequenceResponseList> sequenceResponseListFromJson(String str) => List<SequenceResponseList>.from(json.decode(str).map((x) => SequenceResponseList.fromJson(x)));

String sequenceResponseListToJson(List<SequenceResponseList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SequenceResponseList {
  SequenceResponseList({
    this.seqid,
    this.seqtitle,
    this.sequence,
  });

  String? seqid;
  String? seqtitle;
  String? sequence;

  factory SequenceResponseList.fromJson(Map<String, dynamic> json) => SequenceResponseList(
    seqid: json["seqid"],
    seqtitle: json["seqtitle"],
    sequence: json["sequence"],
  );

  Map<String, dynamic> toJson() => {
    "seqid": seqid,
    "seqtitle": seqtitle,
    "sequence": sequence,
  };
}
