import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqlite_app/model/dish.dart';

class DBHelper {
  static Database _db = _db;

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "dishesDb.db");

    var db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Dishes(name TEXT, description TEXT,price DOUBLE)");
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  // Create Data

  Future<int> createDish(Dish dish) async {
    var dbReady = await db;
    return await dbReady.rawInsert(
        "INSERT INTO Dishes(name,description,price) VALUES ('${dish.name}','${dish.description}','${dish.price}')");
  }

// Update Data

  Future<int> updateDish(Dish dish) async {
    var dbReady = await db;
    return await dbReady.rawInsert(
        "UPDATE Dishes WHERE name ='${dish.name}' SET description='${dish.description}', price='${dish.price}' ");
  }

  // Delete Data

  Future<int> deleteDish(String name) async {
    var dbReady = await db;
    return await dbReady.rawInsert("DELETE FROM Dishes WHERE name='$name'");
  }

  // Read Data

  Future<Dish> readDish(String name) async {
    var dbReady = await db;
    var read =
        await dbReady.rawQuery("SELECT * FROM Dishes WHERE name='$name'");
    return Dish.fromMap(read[0]);
  }

  // Read All Data

  Future<List<Dish>> readAllDishes() async {
    var dbReady = await db;
    List<Map> list = await dbReady.rawQuery("SELECT * FROM Dishes");
    List<Dish> dishes = [];
    for (int i = 0; i < list.length; i++) {
      dishes
          .add(Dish(list[i]["name"], list[i]["description"], list[i]["price"]));
    }

    return dishes;
  }
}
