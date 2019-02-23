import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class Media extends Object {
  final num id;
  final DateTime date;
  final String slug;
  final String type;
  final String link;
  final Map title;
  final num author;
  final Map caption;
  @JsonKey(name: 'media_details')
  final MediaDetails media;
  @JsonKey(name: 'source_url')
  final String sourceUrl;

  Media(this.id, this.date, this.slug, this.type, this.link, this.title,
      this.author, this.caption, this.media, this.sourceUrl);

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);
}

@JsonSerializable(createFactory: false, createToJson: false)
class MediaDetails extends Object {
  final MediaSize thumbnail;
  final MediaSize medium;
  final MediaSize mediumLarge;
  final MediaSize large;
  final MediaSize postThumbnail;
  final MediaSize full;

  MediaDetails(this.thumbnail, this.medium, this.mediumLarge, this.large,
      this.postThumbnail, this.full);

  factory MediaDetails.fromJson(Map<String, dynamic> json) {
    return MediaDetails(
      json['sizes']['thumbnail'] == null
          ? null
          : MediaSize.fromJson(json['sizes']['thumbnail']),
      json['sizes']['medium'] == null
          ? null
          : MediaSize.fromJson(json['sizes']['medium']),
      json['sizes']['medium_large'] == null
          ? null
          : MediaSize.fromJson(json['sizes']['medium_large']),
      json['sizes']['large'] == null
          ? null
          : MediaSize.fromJson(json['sizes']['large']),
      json['sizes']['post-thumbnail'] == null
          ? null
          : MediaSize.fromJson(json['sizes']['post-thumbnail']),
      json['sizes']['full'] == null
          ? null
          : MediaSize.fromJson(json['sizes']['full']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'thumbnail': this.thumbnail,
        'medium': this.medium,
        'mediumLarge': this.mediumLarge,
        'large': this.large,
        'postThumbnail': this.postThumbnail,
        'full': this.full,
      };
}

@JsonSerializable()
class MediaSize extends Object {
  final String file;
  final width;
  final height;
  @JsonKey(name: 'mime_type')
  final mimeType;
  @JsonKey(name: 'source_url')
  final String sourceUrl;

  MediaSize(this.file, this.width, this.height, this.mimeType, this.sourceUrl);

  factory MediaSize.fromJson(Map<String, dynamic> json) =>
      _$MediaSizeFromJson(json);

  Map<String, dynamic> toJson() => _$MediaSizeToJson(this);
}
