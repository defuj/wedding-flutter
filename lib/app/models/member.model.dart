import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MemberModel {
  @JsonKey(name: 'memberID')
  final String? memberID;
  @JsonKey(name: 'memberName')
  String? memberName;
  @JsonKey(name: 'memberPhoneNumer')
  String? memberPhoneNumber;

  MemberModel({
    this.memberID,
    this.memberName,
    this.memberPhoneNumber,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      memberID: json['memberID'] as String?,
      memberName: json['memberName'] as String?,
      memberPhoneNumber: json['memberPhoneNumer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberID': memberID,
      'memberName': memberName,
      'memberPhoneNumer': memberPhoneNumber,
    };
  }
}
