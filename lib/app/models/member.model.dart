import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MemberModel {
  @JsonKey(name: 'id')
  final String? memberID;
  @JsonKey(name: 'nama')
  String? memberName;
  @JsonKey(name: 'id_reservasi')
  final int? reservationID;
  @JsonKey(name: 'isConfirm')
  final int? isConfirm;
  @JsonKey(name: 'panggilan')
  String? nickname;

  MemberModel({
    this.memberID,
    this.memberName,
    this.reservationID,
    this.isConfirm,
    this.nickname,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      memberID: json['id'] as String?,
      memberName: json['nama'] as String?,
      reservationID: int.parse(json['id_reservasi'] ?? '0'),
      isConfirm: int.parse(json['isConfirm'] ?? '0'),
      nickname: json['panggilan'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': memberID,
      'nama': memberName,
      'id_reservasi': reservationID.toString(),
      'isConfirm': isConfirm.toString(),
      'panggilan': nickname,
    };
  }
}
