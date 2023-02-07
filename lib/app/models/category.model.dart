// <option value="1">Appetizer</option>
// <option value="2">Main Course</option>
// <option value="3">Dessert</option>
// <option value="4">Drink</option>

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: 'categoryID')
  final String? categoryID;
  @JsonKey(name: 'categoryName')
  final String? categoryName;

  CategoryModel({
    this.categoryID,
    this.categoryName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryID: json['categoryID'] as String?,
      categoryName: json['categoryName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryID': categoryID,
      'categoryName': categoryName,
    };
  }
}
