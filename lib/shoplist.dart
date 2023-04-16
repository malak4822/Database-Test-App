import 'package:databaseapp/itempage.dart';
import 'package:databaseapp/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyShop extends StatefulWidget {
  MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  late Future func;
  @override
  void initState() {
    func = showRecords();
    super.initState();
  }

  bool essa = false;
  bool isLiked = false;
  final List<List> _rows = [];

  Future showRecords() async {
    wynik = await connection.query('SELECT * FROM thumbnailContent');
    for (var row in wynik) {
      final map = [row[1], row[2]];
      setState(() {
        _rows.add(map);
      });
    }
    debugPrint(_rows.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(9, (index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemPage(
                                id: index,
                                img: _rows[index][0].toString(),
                                name: _rows[index][1].toString(),
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromARGB(255, 164, 164, 164)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                            future: func,
                            builder: ((context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Text("noe");
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Image(
                                          image: NetworkImage(
                                              _rows[index][0].toString()),
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }),
                                      Text(
                                        _rows[index][1].toString(),
                                        style: GoogleFonts.overpass(
                                            color: Colors.white, fontSize: 22),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  );
                                } else {
                                  return Text(
                                      snapshot.connectionState.toString());
                                }
                              } else {
                                return Text(
                                    snapshot.connectionState.toString());
                              }
                            }))
                      ]),
                ));
          }),
        ),
      ),
    );
  }
}
