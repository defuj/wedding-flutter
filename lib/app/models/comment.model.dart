import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommentModel {
  @JsonKey(name: 'nama')
  final String? commentName;
  @JsonKey(name: 'waktu')
  final String? commenyTime;
  @JsonKey(name: 'komentar')
  final String? commentContent;

  CommentModel({
    this.commentName,
    this.commenyTime,
    this.commentContent,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentName: json['nama'] as String?,
      commenyTime: json['commentTime'] as String?,
      commentContent: json['komentar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': commentName,
      'commentTime': commenyTime,
      'komentar': commentContent,
    };
  }
}
