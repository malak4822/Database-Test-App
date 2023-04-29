import 'package:databaseapp/main.dart';
import 'package:databaseapp/shoplist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppIngBasket extends StatefulWidget {
  const ShoppIngBasket({super.key, this.rows});
  final List<List>? rows;

  @override
  State<ShoppIngBasket> createState() => _ShoppIngBasketState();
}

void changeIndex() {
  currentIndex = 0;
}

class _ShoppIngBasketState extends State<ShoppIngBasket> {
  void deleteProduct(int ind) {
    setState(() {
      karta.remove(karta[ind]);
    });
  }

  int removeDuplications() {
    print(karta);
    var distincted = karta.toSet();
    return distincted.length;
  }

  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
      children: [
        const SizedBox(height: 10),
        Text(
          'Basket',
          style:
              GoogleFonts.overpass(fontSize: 38, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Column(
            children: List.generate(karta.length, (index) {
          var item = widget.rows?[karta[index]];
          for (;;) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 120,
              color: const Color.fromARGB(255, 110, 110, 110),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Image(image: NetworkImage(item![0].toString())),
                    onTap: () => changeIndex(),
                  ),
                  IconButton(
                      onPressed: () {
                        deleteProduct(index);
                      },
                      icon: const Icon(
                        Icons.restore_from_trash_rounded,
                        size: 36,
                        color: Colors.white,
                      )),
                  Text(item[1].toString()),
                  // Text('Ilość : ${widget.itemsNumber}'),
                  Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  )
                ],
              ),
            );
          }
        }))
      ],
    )));
  }
}
