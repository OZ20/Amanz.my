// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(json['id'], json['count'], json['description'], json['link'],
      json['name'], json['slug'], json['parent']);
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'description': instance.description,
      'link': instance.link,
      'name': instance.name,
      'slug': instance.slug,
      'parent': instance.parent
    };
