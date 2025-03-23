// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Path _$PathFromJson(Map<String, dynamic> json) => Path(
      (json['points'] as List<dynamic>)
          .map((e) => Point.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PathToJson(Path instance) => <String, dynamic>{
      'points': instance.points.map((e) => e.toJson()).toList(),
    };

Flight _$FlightFromJson(Map<String, dynamic> json) => Flight(
      flightDate: DateTime.parse(json['flight_date'] as String),
      ico24: json['ico24'] as String,
      destination: json['destination'] as String,
      path: Path.fromJson(json['path'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$FlightToJson(Flight instance) => <String, dynamic>{
      'flight_date': instance.flightDate.toIso8601String(),
      'ico24': instance.ico24,
      'path': instance.path.toJson(),
      'destination': instance.destination,
      'image_url': instance.imageUrl,
    };
