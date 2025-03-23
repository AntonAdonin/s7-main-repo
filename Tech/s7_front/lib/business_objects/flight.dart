import 'package:json_annotation/json_annotation.dart';
import 'package:s7_front/business_objects/point.dart';

part 'flight.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Path {
  late final List<Point> points;

  Path(this.points);

  factory Path.fromJson(Map<String, dynamic> json) => _$PathFromJson(json);

  @override
  String toString() {
    return "Path: $points";
  }

  Map<String, dynamic> toJson() => _$PathToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Flight {
  late DateTime flightDate;
  late final String ico24;
  late final Path path;
  late final String destination;
  late final String? imageUrl;

  Flight({required this.flightDate, required this.ico24, required this.destination, required this.path, this.imageUrl});

  @override
  String toString() {
    return "Flight: $flightDate, $ico24, $path, $destination";
  }

  factory Flight.fromJson(Map<String, dynamic> json) => _$FlightFromJson(json);

  Map<String, dynamic> toJson() => _$FlightToJson(this);
}
