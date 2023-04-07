import 'package:databaseapp/itempage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProducts extends StatelessWidget {
  MyProducts({super.key, required this.voidCallback, this.myRows});
  final Future voidCallback;
  bool essa = false;
  final myRows;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(6, (index) {
            var row;
            void e() async {
              row = await myRows[index];
            }

            print(row);
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemPage(
                                id: index,
                                name: row['name'] ?? "",
                                email: row['email'] ?? "",
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
                            future: voidCallback.then((value) => value),
                            builder: ((context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(
                                  '${row['name']}\n\n${row['email']}',
                                  style: GoogleFonts.overpass(
                                      color: Colors.white, fontSize: 22),
                                  textAlign: TextAlign.center,
                                );
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
