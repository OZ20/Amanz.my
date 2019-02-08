import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(nullable: true)
class Post extends Object {

  final num id;
  final DateTime date;
  final DateTime date_gmt;
  final String slug;
  final String status;
  final String type;
  final String link;
  final Map title;
  final content;
  final excerpt;
  final num author;
  @JsonKey(name: 'featured_media')
  final featuredMedia;
  @JsonKey(name: 'comment_status')
  final commentStatus;
  @JsonKey(name: 'ping_status')
  final pingStatus;
  final template;
  final Meta meta;
  final List categories;
  final List tags;
  @JsonKey(name: 'jetpack_featured_media_url')
  final jpFeaturedMedia;
  @JsonKey(name: 'jetpack_publicize_connections')
  final jpPublicizeConnections;
  @JsonKey(name: 'jetpack_shortlink')
  final jpShortlink;
  @JsonKey(name: '_links')
  final links;

  Post(this.id, this.date, this.date_gmt, this.slug, this.status, this.type,
      this.link, this.title, this.content, this.excerpt, this.author,
      this.featuredMedia, this.commentStatus, this.pingStatus, this.template,
      this.meta, this.categories, this.tags, this.jpFeaturedMedia,
      this.jpPublicizeConnections, this.jpShortlink, this.links);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map toJson() => _$PostToJson(this);

}

@JsonSerializable()
class Meta extends Object {

  @JsonKey(name: 'amp_status')
  final ampStatus;
  @JsonKey(name: 'spay_email')
  final spayEmail;
  @JsonKey(name: 'jetpack_publicize_message')
  final jetpack;

  Meta(this.ampStatus, this.spayEmail, this.jetpack);

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map toJson() => _$MetaToJson(this);
}