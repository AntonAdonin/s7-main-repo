import 'package:json_annotation/json_annotation.dart';
import 'package:s7_front/business_objects/point.dart';

part 'landmark.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Landmark {
  final Point point;
  final String name;
  final String description;
  final String briefDescription;
  final String imageUrl;

  Landmark({
    required this.point,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.briefDescription,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) => _$LandmarkFromJson(json);

  Map<String, dynamic> toJson() => _$LandmarkToJson(this);
}
