import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_qr/mdels/carnet_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? _myDatabase;
  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> getDatabase() async {
    if (_myDatabase != null) return _myDatabase;
    _myDatabase = await initDB();
    return _myDatabase;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path =
        join(documentDirectory.path, "CarnetDB.db"); // ruta donde se creará
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE CARNET(id INTEGER PRIMARY KEY AUTOINCREMENT, fullName TEXT, dni TEXT, url TEXT)",
      );
    });
  }

  Future<List<CarnetModel>> getCarnetList() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> res = await db!.query("CARNET");

    /*// otra alternativa para recorrer la lista res
    List<CarnetModel> lista = [];
    for(var item in res){
      lista.add(
        CarnetModel.fromJson(item),
      );
    }*/

    // validamos con res.isNotEmpty si está vacío o no
    // con .toList() convertimos carnets en una lista []
    List<CarnetModel> carnets = res.isNotEmpty ? res.map<CarnetModel>((e) => CarnetModel.fromJson(e)).toList() : [];
    return carnets;
  }

  Future<int> insertCarnet(CarnetModel carnet) async {
    final db = await getDatabase();
    int res = await db!.insert("CARNET", carnet.toJson());
    return res;
  }

  Future<int> deleteCarnet(int id) async {
    final db = await getDatabase();
    int res = await db!.delete("CARNET", where: "id = $id");
    return res;
  }
}
