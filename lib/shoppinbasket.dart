import 'package:databaseapp/main.dart';
import 'package:databaseapp/shoplist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppIngBasket extends StatefulWidget {
  const ShoppIngBasket({super.key, this.rows});
  final List<List>? rows;

  @override
  State<ShoppIngBasket> createState() => _ShoppIngBasketState();
}

void changeIndex() {
  currentIndex = 0;
}

List kartaCopy = karta;
Map map = {};

class _ShoppIngBasketState extends State<ShoppIngBasket> {
  void deleteProduct(quantity, key) async {
    karta.remove(key);
    setState(() {
      --quantity;
    });
  }

  List<int> distinctedCart = [];

  int removeDuplications() {
    distinctedCart = karta.toSet().toList();
    return distinctedCart.length;
  }

  @override
  Widget build(BuildContext context) {
    map.clear();
    for (int key in karta) {
      if (!map.containsKey(key)) {
        map[key] = 1;
      } else {
        map[key] += 1;
      }
    }
    debugPrint(karta.toString());

    return Scaffold(
        body: Center(
            child: ListView(children: [
      const SizedBox(height: 10),
      Text(
        'Basket',
        style: GoogleFonts.overpass(fontSize: 38, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      Column(
          children: List.generate(removeDuplications(), (index) {
        int productKey = map.keys.toList().elementAt(index);
        int productQuantity = map[productKey];
        bool isChecked = true;
        List<dynamic>? itemContainer = widget.rows?[productKey];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          height: 120,
          color: const Color.fromARGB(255, 110, 110, 110),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Image(image: NetworkImage(itemContainer![0].toString())),
                onTap: () => changeIndex(),
              ),
              IconButton(
                  onPressed: () {
                    deleteProduct(productQuantity, productKey);
                  },
                  icon: const Icon(
                    Icons.restore_from_trash_rounded,
                    size: 32,
                    color: Colors.white,
                  )),
              Expanded(
                  child: Text(itemContainer[1].toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.overpass(color: Colors.white))),
              Text(
                'Ilość : $productQuantity',
                style: GoogleFonts.overpass(color: Colors.white),
              ),
              Switch(
                  value: isChecked,
                  onChanged: (bool a) {
                    setState(() {
                      isChecked = !a;
                    });
                  })
            ],
          ),
        );
      }))
    ])));
  }
}
