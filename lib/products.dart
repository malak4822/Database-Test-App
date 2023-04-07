import 'package:databaseapp/itempage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({super.key, this.myRows, this.searchFunc});
  final myRows;
  final searchFunc;
  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  bool essa = false;
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
          children: List.generate(18, (index) {
            final row = widget.myRows[index];
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ItemPage()));
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
                            builder: (context, snapshot) => Text(
                                  "${row['name']}\n\n${row['email']}",
                                  style: GoogleFonts.overpass(
                                      color: Colors.white, fontSize: 22),
                                  textAlign: TextAlign.center,
                                )),
                      ]),
                ));
          }),
        ),
      ),
    );
  }
}
