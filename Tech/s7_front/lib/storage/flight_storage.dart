import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../business_objects/flight.dart';
import 'local_storage.dart';

class FlightsStorage {
  final String _filename = "flight";
  late final LocalStorage _storage;

  static final FlightsStorage _flightsStorage = FlightsStorage._privateConstructor();

  factory FlightsStorage() {
    return _flightsStorage;
  }

  FlightsStorage._privateConstructor() {
    _storage = LocalStorage(_filename);
  }

  Future<void> clear() async {
    await _storage.database.delete(_filename);
  }

  Future<void> drop() async {
    await _storage.database.execute("DROP TABLE IF EXISTS $_filename");
  }

  Future<void> init() async {
    await _storage.init();
    await _storage.database.execute(
      "CREATE TABLE IF NOT EXISTS $_filename(flight_date TEXT, ico24 TEXT PRIMARY KEY, path TEXT, destination TEXT, image_url TEXT)",
    );
  }

  Future<List<Flight>> getFlights() async {
    List<Map<String, dynamic>> jsonList = await _storage.database.query(_filename);
    return jsonList.map((e) {
      Map<String, dynamic> flight = Map.of(e);
      flight["path"] = jsonDecode(flight["path"]);
      return Flight.fromJson(flight);
    }).toList();
  }

  Future<void> addFlight(Flight flight) async {
    Map<String, dynamic> values = flight.toJson();
    values["path"] = jsonEncode(values["path"]);
    await _storage.database.insert(_filename, values, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Flight?> getFlight(String ico24) async {
    List<Map<String, dynamic>> jsonList = await _storage.database.query(
      _filename,
      where: "ico24 = ?",
      whereArgs: [ico24],
    );
    if (jsonList.isEmpty) {
      return null;
    } else {
      Map<String, dynamic> flight = Map.of(jsonList[0]);
      flight["path"] = jsonDecode(flight["path"]);
      return Flight.fromJson(flight);
    }
  }
}
