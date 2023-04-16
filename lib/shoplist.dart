import 'package:databaseapp/itempage.dart';
import 'package:databaseapp/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyShop extends StatelessWidget {
  MyShop({super.key, this.myRows});
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
            return InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ItemPage(
                  //               id: index,
                  //               name: myRows['thumbnailURL'].toString(),
                  //               email: myRows['author'].toString(),
                  //             )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromARGB(255, 164, 164, 164)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                            future: showRecords(),
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
                                              myRows['thumbnailURL']
                                                  .toString()),
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
                                        myRows['author'].toString(),
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
