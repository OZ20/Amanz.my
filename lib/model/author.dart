import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author extends Object {
  final num id;
  final String name;
  final String url;
  final String description;
  final String link;
  final String slug;
  @JsonKey(name: 'avatar_urls')
  final Map<String, dynamic> avatarUrl;
  @JsonKey(name: '_links')
  final links;

  Author(this.id, this.name, this.url, this.description, this.link, this.slug,
      this.avatarUrl, this.links);

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
