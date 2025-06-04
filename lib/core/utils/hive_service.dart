 import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  // Open a box
  static Future<Box> openBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  // Store a value
  static Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox(boxName);
    await box.put(key, value);
  }

  // Retrieve a value
  static Future<T?> get<T>(String boxName, String key) async {
    final box = await openBox(boxName);
    return box.get(key) as T?;
  }

  // Delete a value
  static Future<void> delete(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }

  // Clear all values in a box
  static Future<void> clearBox(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

  // Get all keys
  static Future<List<String>> getKeys(String boxName) async {
    final box = await openBox(boxName);
    return box.keys.cast<String>().toList();
  }

  // Get all values
  static Future<List<dynamic>> getValues(String boxName) async {
    final box = await openBox(boxName);
    return box.values.toList();
  }
}
