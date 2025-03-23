import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:s7_front/business_objects/landmark.dart';
import 'local_storage.dart';

class LandmarksStorage {
  final String _filename = "landmark";
  late final LocalStorage _storage;

  static final LandmarksStorage _flightsStorage = LandmarksStorage._privateConstructor();

  factory LandmarksStorage() {
    return _flightsStorage;
  }

  LandmarksStorage._privateConstructor() {
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
      "CREATE TABLE IF NOT EXISTS $_filename(name TEXT PRIMARY TEXT, point TEXT, description TEXT, brief_description TEXT, image_url TEXT)",
    );
  }

  Future<List<Landmark>> getLandmarks() async {
    List<Map<String, dynamic>> jsonList = await _storage.database.query(_filename);
    return jsonList.map((e) {
      Map<String, dynamic> landmark = Map.of(e);
      landmark["point"] = jsonDecode(landmark["point"]);
      return Landmark.fromJson(landmark);
    }).toList();
  }

  Future<void> addLandmark(Landmark landmark) async {
    Map<String, dynamic> values = landmark.toJson();
    values["point"] = jsonEncode(values["point"]);
    await _storage.database.insert(_filename, values, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Future<Landmark?> getLandmark(String ico24) async {
  //   List<Map<String, dynamic>> jsonList = await _storage.database.query(
  //     _filename,
  //     where: "ico24 = ?",
  //     whereArgs: [ico24],
  //   );
  //   if (jsonList.isEmpty) {
  //     return null;
  //   } else {
  //     Map<String, dynamic> landmark = Map.of(jsonList[0]);
  //     landmark["path"] = jsonDecode(landmark["path"]);
  //     return Landmark.fromJson(landmark);
  //   }
  // }
}
