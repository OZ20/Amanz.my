// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
      json['id'] as num,
      json['name'] as String,
      json['url'] as String,
      json['description'] as String,
      json['link'] as String,
      json['slug'] as String,
      json['avatar_urls'] as Map<String, dynamic>,
      json['_links']);
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'description': instance.description,
      'link': instance.link,
      'slug': instance.slug,
      'avatar_urls': instance.avatarUrl,
      '_links': instance.links
    };
