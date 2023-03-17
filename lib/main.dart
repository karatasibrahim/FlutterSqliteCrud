import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:sqlite_app/model/dish.dart';
import 'package:sqlite_app/database/dbHelper.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        // ignore: deprecated_member_use
        accentColor: Colors.cyan[600]),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "", description = "";
  double price = 0.0;

  getName(name) {
    this.name = name;
    print(this.name);
  }

  getDescription(description) {
    this.description = description;
    print(this.description);
  }

  getPrice(price) {
    this.price = double.parse(price);
    print(this.price);
  }

  createData() {
    setState(() {
      var dbHelper = DBHelper();
      var dish = Dish(name, description, price);
      dbHelper.createDish(dish);
    });
  }

  readData() {
    var dbHelper = DBHelper();
    Future<Dish> dish = dbHelper.readDish(name);
    dish.then((dishData) {
      print("${dishData.name},${dishData.description},${dishData.price}");
    });
  }

  Future<List<Dish>> getAllDishes() async {
    var dbHelper = DBHelper();
    Future<List<Dish>> dishes = dbHelper.readAllDishes();
    return dishes;
  }

  updateData() {
    setState(() {
      var dbHelper = DBHelper();
      var dish = Dish(name, description, price);
      dbHelper.updateDish(dish);
    });
  }

  deleteData() {
    setState(() {
      var dbHelper = DBHelper();
      dbHelper.deleteDish(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sqlite Crud İşlemleri"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Ad"),
                onChanged: (String name) {
                  getName(name);
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Açıklama"),
                onChanged: (String description) {
                  getDescription(description);
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Fiyat"),
                onChanged: (String price) {
                  getPrice(price);
                },
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: MaterialButton(
                        color: Colors.green,
                        child: Text("Kaydet"),
                        onPressed: () {
                          createData();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Text("Oku"),
                        onPressed: () {
                          readData();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: MaterialButton(
                        color: Colors.orange,
                        child: Text("Güncelle"),
                        onPressed: () {
                          updateData();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: MaterialButton(
                        color: Colors.red,
                        child: Text("Sil"),
                        onPressed: () {
                          deleteData();
                        },
                      ),
                    ),
                    // Row(
                    //   textDirection: TextDirection.ltr,
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: Text("Yemek Adı: "),
                    //     ),
                    //     Expanded(
                    //       child: Text("Açıklama: "),
                    //     ),
                    //     Expanded(
                    //       child: Text("Fiyat: "),
                    //     )
                    //   ],
                    // ),
                    // FutureBuilder<List<Dish>>(
                    //     future: getAllDishes(),
                    //     builder: (context, snapshot) {
                    //       return ListView.builder(
                    //           shrinkWrap: true,
                    //           itemCount: snapshot.data?.length,
                    //           itemBuilder: (context, index) {
                    //             return Row(
                    //               textDirection: TextDirection.ltr,
                    //               children: <Widget>[
                    //                 Expanded(
                    //                   child: Text(snapshot.data![index].name),
                    //                 ),
                    //                 Expanded(
                    //                   child: Text(
                    //                       snapshot.data![index].description),
                    //                 ),
                    //                 Expanded(
                    //                   child: Text(snapshot.data![index].price
                    //                       .toString()),
                    //                 )
                    //               ],
                    //             );
                    //           });
                    //     })
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
