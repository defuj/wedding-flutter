import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MenuModel {
  @JsonKey(name: 'id')
  final String? menuID;
  @JsonKey(name: 'id_kategori')
  final String? categoryID;
  @JsonKey(name: 'nama_menu')
  final String? menuName;
  @JsonKey(name: 'deskripsi')
  final String? menuDesc;
  @JsonKey(name: 'img_cover')
  final String? menuCoverPicture;
  @JsonKey(name: 'img_second')
  final String? menuPicture1;
  @JsonKey(name: 'img_third')
  final String? menuPicture2;
  @JsonKey(name: 'stok')
  final int? menuStock;

  MenuModel({
    this.menuID,
    this.categoryID,
    this.menuName,
    this.menuDesc,
    this.menuCoverPicture,
    this.menuPicture1,
    this.menuPicture2,
    this.menuStock,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      menuID: json['id'] as String?,
      categoryID: json['id_kategori'] as String?,
      menuName: json['nama_menu'] as String?,
      menuDesc: json['deskripsi'] as String?,
      menuCoverPicture: json['img_cover'] as String?,
      menuPicture1: json['img_second'] as String?,
      menuPicture2: json['img_third'] as String?,
      menuStock: int.parse(json['stok'] ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': menuID.toString(),
      'id_kategori': categoryID.toString(),
      'nama_menu': menuName,
      'deskripsi': menuDesc,
      'img_cover': menuCoverPicture,
      'img_second': menuPicture1,
      'img_third': menuPicture2,
      'stok': menuStock.toString(),
    };
  }
}
