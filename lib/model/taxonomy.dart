import 'package:json_annotation/json_annotation.dart';

part 'taxonomy.g.dart';

@JsonSerializable()
class Taxonomy extends Object {

  final num id;
  final String link;
  final String name;
  final String slug;
  final String taxonomy;
  @JsonKey(name: '_links')
  final links;

  Taxonomy(this.id, this.link, this.name, this.slug, this.taxonomy, this.links);

  factory Taxonomy.fromJson(Map<String,dynamic> json ) => _$TaxonomyFromJson(json);

  Map<String,dynamic> toJson() => _$TaxonomyToJson(this);
}