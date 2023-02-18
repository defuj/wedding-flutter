import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommentModel {
  @JsonKey(name: 'id')
  final String? commentID;
  @JsonKey(name: 'nama')
  final String? commentName;
  @JsonKey(name: 'waktu')
  final String? commenyTime;
  @JsonKey(name: 'komentar')
  final String? commentContent;

  CommentModel({
    this.commentID,
    this.commentName,
    this.commenyTime,
    this.commentContent,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentID: json['id'] as String?,
      commentName: json['nama'] as String?,
      commenyTime: json['waktu'] as String?,
      commentContent: json['komentar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': commentID,
      'nama': commentName,
      'waktu': commenyTime,
      'komentar': commentContent,
    };
  }
}
