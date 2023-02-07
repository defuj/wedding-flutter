import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SessionModel {
  @JsonKey(name: 'id')
  final String? sessionID;
  @JsonKey(name: 'sesi')
  String? sessionName;
  @JsonKey(name: 'waktu_mulai')
  String? sessionStart;
  @JsonKey(name: 'waktu_berakhir')
  String? sessionEnd;
  @JsonKey(name: 'kuota')
  String? sessionQuota;

  SessionModel({
    this.sessionID,
    this.sessionName,
    this.sessionStart,
    this.sessionEnd,
    this.sessionQuota,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      sessionID: json['id'] as String?,
      sessionName: json['sesi'] as String?,
      sessionStart: json['waktu_mulai'] as String?,
      sessionEnd: json['waktu_berakhir'] as String?,
      sessionQuota: json['kuota'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': sessionID,
      'sesi': sessionName,
      'waktu_mulai': sessionStart,
      'waktu_berakhir': sessionEnd,
      'kuota': sessionQuota,
    };
  }
}
