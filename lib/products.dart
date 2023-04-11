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
          children: List.generate(9, (index) {
            var row;
            void e() async {
              row = await myRows[index];
            }

            e();

            print(row);
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemPage(
                                id: index,
                                name: row['thumbnailURL'].toString() ?? "",
                                email: row['author'].toString() ?? "",
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
                            future: voidCallback,
                            builder: ((context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Image(
                                        image:
                                            NetworkImage(row['thumbnailURL'].toString())),
                                    Text(
                                      row['author'].toString(),
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
                            }))
                      ]),
                ));
          }),
        ),
      ),
    );
  }
}
