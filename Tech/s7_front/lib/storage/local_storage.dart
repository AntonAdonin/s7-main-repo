import "dart:io";

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  late final String _filename;
  late Database database;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = await openDatabase(join(await getDatabasesPath(), '$_filename.db'));
    print(database);
  }

  LocalStorage(this._filename);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_filename');
  }

  Future<File> write(String data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(data);
  }

  Future<String> read() async {
    final file = await _localFile;

    // Read the file
    String contents = await file.readAsString();

    return contents;
  }
}
