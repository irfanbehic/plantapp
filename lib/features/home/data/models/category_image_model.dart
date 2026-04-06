import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_image_model.freezed.dart';
part 'category_image_model.g.dart';

@freezed
class CategoryImageModel with _$CategoryImageModel {
  const factory CategoryImageModel({
    required int id,
    required String name,
    required String url,
    int? width,
    int? height,
  }) = _CategoryImageModel;

  factory CategoryImageModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryImageModelFromJson(json);
}
