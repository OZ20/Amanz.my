// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
      json['id'] as num,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      json['date_gmt'] == null
          ? null
          : DateTime.parse(json['date_gmt'] as String),
      json['slug'] as String,
      json['status'] as String,
      json['type'] as String,
      json['link'] as String,
      json['title'] as Map<String, dynamic>,
      json['content'],
      json['excerpt'],
      json['author'] as num,
      json['featured_media'],
      json['comment_status'],
      json['ping_status'],
      json['template'],
      json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      json['categories'] as List,
      json['tags'] as List,
      json['jetpack_featured_media_url'],
      json['jetpack_publicize_connections'],
      json['jetpack_shortlink'],
      json['_links']);
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'date_gmt': instance.date_gmt?.toIso8601String(),
      'slug': instance.slug,
      'status': instance.status,
      'type': instance.type,
      'link': instance.link,
      'title': instance.title,
      'content': instance.content,
      'excerpt': instance.excerpt,
      'author': instance.author,
      'featured_media': instance.featuredMedia,
      'comment_status': instance.commentStatus,
      'ping_status': instance.pingStatus,
      'template': instance.template,
      'meta': instance.meta,
      'categories': instance.categories,
      'tags': instance.tags,
      'jetpack_featured_media_url': instance.jpFeaturedMedia,
      'jetpack_publicize_connections': instance.jpPublicizeConnections,
      'jetpack_shortlink': instance.jpShortlink,
      '_links': instance.links
    };

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return Meta(json['amp_status'], json['spay_email'],
      json['jetpack_publicize_message']);
}

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'amp_status': instance.ampStatus,
      'spay_email': instance.spayEmail,
      'jetpack_publicize_message': instance.jetpack
    };