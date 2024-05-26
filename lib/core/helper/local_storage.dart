import 'dart:io';

import 'package:hive/hive.dart';

import '../util/constants/app_data.dart';
import 'package:path_provider/path_provider.dart' as path;

class LocalStorage {
  static LocalStorage? _singleton;

  LocalStorage._internal();

  factory LocalStorage() {
    _singleton = _singleton ?? LocalStorage._internal();
    return _singleton!;
  }

  late final Box box;
  late final Directory storagePath;

  initiateStorage() async {
    storagePath = await path.getApplicationDocumentsDirectory();
    box = await Hive.openBox(AppData.STORAGE_BOX,path:storagePath.path);
  }

  readFromStorage({required String key}) {
    return box.get(key);
  }

  writeOnStorage({required String key, required data}) {
    box.put(key, data);
  }
}