import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

// Future<Database> initializeDb() async {
//   // Get the path to the local storage
//   var databasesPath = await getDatabasesPath();
//   var path = join(databasesPath, "khushikids.db");
//
//   // Check if the database already exists
//   var exists = await databaseExists(path);
//
//   if (!exists) {
//     // If it doesn't exist, copy it from the assets folder
//     try {
//       await Directory(dirname(path)).create(recursive: true);
//       ByteData data = await rootBundle.load("assets/khushikids.db");
//       List<int> bytes = data.buffer.asUint8List();
//       await File(path).writeAsBytes(bytes, flush: true);
//     } catch (e) {
//       print("Error copying database: $e");
//     }
//   }
//
//   // Open the database
//   return await openDatabase(path);
// }

Future<Database> initializeDb() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "khushikids.db");

  var exists = await databaseExists(path);

  if (!exists) {
    try {
      await Directory(dirname(path)).create(recursive: true);
      ByteData data = await rootBundle.load("assets/khushikids.db");
      List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes, flush: true);
    } catch (e) {
      print("Error copying database: $e");
    }
  }

  // Open database with READ & WRITE permissions
  return await openDatabase(
    path,
    version: 1,
    readOnly: false, // 🚀 Make database writable
  );
}