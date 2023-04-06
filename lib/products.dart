import 'package:flutter/material.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({super.key, this.myRows});
  final myRows;

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  bool essa = false;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: widget.myRows.length,
        itemBuilder: (context, index) {
          final row = widget.myRows[index];

          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(row['name']),
                if (isLiked) const Icon(Icons.heart_broken_outlined),
                if (!isLiked) const Icon(Icons.heart_broken_rounded),
              ],
            ),
            subtitle: Text(row['email']),
          );
        },
      ),
    );
  }
}
