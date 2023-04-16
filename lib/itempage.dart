import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemPage extends StatefulWidget {
  const ItemPage(
      {super.key, required this.id, required this.name, required this.img});
  final id;
  final name;
  final img;

  @override
  State<ItemPage> createState() => _MyItemPageState();
}

class _MyItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.insert_emoticon,
                size: 50,
                color: Colors.black,
              ),
              Text(
                widget.name,
                style: GoogleFonts.overpass(fontSize: 40, color: Colors.black),
              ),
              Image.network(widget.img)
            ],
          ),
        ));
  }
}
