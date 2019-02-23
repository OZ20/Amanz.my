import 'package:amanzmy/model/author.dart';
import 'package:amanzmy/model/media.dart';
import 'package:amanzmy/model/taxonomy.dart';
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
  final PostMeta meta;
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
  @JsonKey(name: '_embedded')
  final PostEmbedded embedded;

  Post(
      this.id,
      this.date,
      this.date_gmt,
      this.slug,
      this.status,
      this.type,
      this.link,
      this.title,
      this.content,
      this.excerpt,
      this.author,
      this.featuredMedia,
      this.commentStatus,
      this.pingStatus,
      this.template,
      this.meta,
      this.categories,
      this.tags,
      this.jpFeaturedMedia,
      this.jpPublicizeConnections,
      this.jpShortlink,
      this.links,
      this.embedded);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map toJson() => _$PostToJson(this);
}

@JsonSerializable()
class PostMeta extends Object {
  @JsonKey(name: 'amp_status')
  final ampStatus;
  @JsonKey(name: 'spay_email')
  final spayEmail;
  @JsonKey(name: 'jetpack_publicize_message')
  final jetpack;

  PostMeta(this.ampStatus, this.spayEmail, this.jetpack);

  factory PostMeta.fromJson(Map<String, dynamic> json) =>
      _$PostMetaFromJson(json);

  Map<String, dynamic> toJson() => _$PostMetaToJson(this);
}

@JsonSerializable()
class PostEmbedded extends Object {
  @JsonKey(name: 'wp:featuredmedia')
  final List<Media> media;
  final List<Author> author;
  @JsonKey(name: 'wp:term')
  final PostWpTerm wpTerm;

  PostEmbedded(this.media, this.author, this.wpTerm);

  factory PostEmbedded.fromJson(Map<String, dynamic> json) =>
      _$PostEmbeddedFromJson(json);

  Map<String, dynamic> toJson() => _$PostEmbeddedToJson(this);
}

@JsonSerializable(createFactory: false, createToJson: false)
class PostWpTerm extends Object {
  final List<Taxonomy> category;
  final List<Taxonomy> postTag;

  PostWpTerm(this.category, this.postTag);

  factory PostWpTerm.fromJson(List<dynamic> wpTerm) {
    List<Taxonomy> category = List<Taxonomy>();
    wpTerm[0].forEach((data) => category.add(Taxonomy.fromJson(data)));
    List<Taxonomy> postTag = List<Taxonomy>();
    wpTerm[0].forEach((data) => postTag.add(Taxonomy.fromJson(data)));

    return new PostWpTerm(category, postTag);
  }

  Map<String, dynamic> toJson() => _$PostWpTermToJson(this);

  Map<String, dynamic> _$PostWpTermToJson(PostWpTerm instance) =>
      <String, dynamic>{
        'category': instance.category,
        'post_tag': instance.postTag,
      };
}
