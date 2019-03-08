import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Object {
  final id;
  final count;
  final description;
  final link;
  final name;
  final slug;
  final parent;

  Category(this.id, this.count, this.description, this.link, this.name,
      this.slug, this.parent);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
