import 'package:json_annotation/json_annotation.dart';
import 'package:wedding/app/index.dart';

@JsonSerializable()
class CartModel {
  @JsonKey(name: 'menu')
  MenuModel? menu;
  @JsonKey(name: 'members')
  List<MemberModel>? members;
  @JsonKey(name: 'note')
  String? note;

  CartModel({
    this.menu,
    this.members,
    this.note,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      menu: json['menu'] != null ? MenuModel.fromJson(json['menu']) : null,
      members: json['members'] != null
          ? (json['members'] as List)
              .map((e) => MemberModel.fromJson(e))
              .toList()
          : [],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu': menu,
      'members': members,
      'note': note,
    };
  }
}
