import 'dart:async';
import 'dart:math';

import 'package:databaseapp/itempage.dart';
import 'package:databaseapp/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();

  List<List>? get getRows {
    return _rows;
  }
}

List<int> karta = [];
List<List> _rows = [];
int productsNumber = 0;

class _MyShopState extends State<MyShop> {
  late Future func;
  @override
  void initState() {
    loadBusketItems();
    getProducts().then((value) => fillProductsList());
    super.initState();
  }

  void loadBusketItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> kartaString = prefs.getStringList('basketNumbers') ?? [];
    karta = kartaString.map((e) => int.parse(e)).toList();
  }

  bool essa = false;
  bool isLiked = false;

  void fillProductsList() {
    _rows = [];
    for (var row in wynik) {
      final map = [row[1], row[2]];
      setState(() {
        _rows.add(map);
      });
    }
    productsNumber = _rows.length;
  }

  Future getProducts() async {
    wynik = await connection.query('SELECT * FROM thumbnailContent');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 3));

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              _refreshIndicatorKey.currentState!.show();
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
        onRefresh: _handleRefresh,
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
                            builder: (context) =>
                                ItemPage(id: index, myRows: _rows)));
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