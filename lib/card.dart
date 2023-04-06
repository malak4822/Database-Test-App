import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key, this.myRows});
  final myRows;

  @override
  State<MyCard> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.card_giftcard, size: 50));
  }
}
