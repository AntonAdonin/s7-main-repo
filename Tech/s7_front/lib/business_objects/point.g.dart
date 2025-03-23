// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Point _$PointFromJson(Map<String, dynamic> json) => Point(
      (json['lat'] as num).toDouble(),
      (json['lon'] as num).toDouble(),
      (json['height'] as num).toDouble(),
    );

Map<String, dynamic> _$PointToJson(Point instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'height': instance.height,
    };
