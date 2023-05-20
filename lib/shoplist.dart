import 'dart:async';
import 'package:databaseapp/itempage.dart';
import 'package:databaseapp/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyShop extends StatefulWidget {
  MyShop({super.key, this.backFromBuyMore, this.fillProductsListe});

  var fillProductsListe;

  @override
  State<MyShop> createState() => MyShopState();

  final Function? backFromBuyMore;
  List<List>? get getRows {
    return _rows;
  }
}

var time;

List<int> karta = [];
List<List> _rows = [];
int productsNumber = 0;

class MyShopState extends State<MyShop> {
  fillProductsList(connection) async {
    final stopwatch = Stopwatch()..start();
    wynik = await connection.query('SELECT * FROM thumbnailContent');
    _rows = [];
    for (var row in wynik) {
      final map = [row[1], row[2]];
      setState(() {
        _rows.add(map);
      });
    }
    productsNumber = _rows.length;
    time = stopwatch.elapsed;
    stopwatch.stop();
  }

  late Future func;

  @override
  void initState() {
    loadBusketItems();
    fillProductsList(null);
    super.initState();
  }

  void loadBusketItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> kartaString = prefs.getStringList('basketNumbers') ?? [];
    karta = kartaString.map((e) => int.parse(e)).toList();
  }

  bool essa = false;
  bool isLiked = false;
  Future empty() async {}
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
        onRefresh: () {
          return empty();
          // fillProductsList();
          // return handleRefresh();
        },
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: List.generate(productsNumber, (index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItemPage(
                                id: index,
                                myRows: _rows,
                                backFromBuyMore: widget.backFromBuyMore)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(blurRadius: 3),
                        ],
                        image: DecorationImage(
                          onError: (exception, stackTrace) =>
                              const Text("Refresh App"),
                          fit: BoxFit.fill,
                          image: NetworkImage(_rows[index][0].toString()),
                        ),
                        borderRadius: BorderRadius.circular(16),
                        color: const Color.fromARGB(255, 164, 164, 164)),
                    child: Text(
                      _rows[index][1].toString(),
                      style: GoogleFonts.overpass(
                          color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ));
            }),
          ),
        ));
  }
}

 // Stack(children: [
                //   FutureBuilder(
                //       initialData: '',
                //       future: func,
                //       builder: ((context, snapshot) {
                //         if (snapshot.connectionState ==
                //             ConnectionState.waiting) {
                //           return const CircularProgressIndicator();
                //         } else if (snapshot.connectionState ==
                //             ConnectionState.done) {
                //           if (snapshot.hasError) {
                //             return const Center(
                //               child: Text('Refresh App'),
                //             );
                //           } else {
                //             return Text('');
                //           }
                //         } else {
                //           return Text(snapshot.connectionState.toString());
                //         }
                //       }))
                // ]),