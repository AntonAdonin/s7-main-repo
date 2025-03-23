import 'package:json_annotation/json_annotation.dart';

part 'point.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Point {
  late final double lat;
  late final double lon;
  late final double height;

  Point(this.lat, this.lon, this.height);

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);

  @override
  String toString() {
    return "Point: $lat, $lon, $height";
  }

  Map<String, dynamic> toJson() => _$PointToJson(this);
}