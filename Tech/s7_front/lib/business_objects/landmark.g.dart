// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Landmark _$LandmarkFromJson(Map<String, dynamic> json) => Landmark(
      point: Point.fromJson(json['point'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      briefDescription: json['brief_description'] as String,
    );

Map<String, dynamic> _$LandmarkToJson(Landmark instance) => <String, dynamic>{
      'point': instance.point,
      'name': instance.name,
      'description': instance.description,
      'brief_description': instance.briefDescription,
      'image_url': instance.imageUrl,
    };
