// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) {
  return Media(
      json['id'] as num,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      json['slug'] as String,
      json['type'] as String,
      json['link'] as String,
      json['title'] as Map<String, dynamic>,
      json['author'] as num,
      json['caption'] as Map<String, dynamic>,
      json['media_details'] == null
          ? null
          : MediaDetails.fromJson(
              json['media_details'] as Map<String, dynamic>),
      json['source_url'] as String);
}

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'slug': instance.slug,
      'type': instance.type,
      'link': instance.link,
      'title': instance.title,
      'author': instance.author,
      'caption': instance.caption,
      'media_details': instance.media,
      'source_url': instance.sourceUrl
    };

MediaSize _$MediaSizeFromJson(Map<String, dynamic> json) {
  return MediaSize(json['file'] as String, json['width'], json['height'],
      json['mime_type'], json['source_url'] as String);
}

Map<String, dynamic> _$MediaSizeToJson(MediaSize instance) => <String, dynamic>{
      'file': instance.file,
      'width': instance.width,
      'height': instance.height,
      'mime_type': instance.mimeType,
      'source_url': instance.sourceUrl
    };
