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

var countin = karta;

class _ShoppIngBasketState extends State<ShoppIngBasket> {
  var map = Map();

  void deleteProduct(int ind) {
    setState(() {
      karta.remove(karta[ind]);
    });
  }

  List<int> distinctedCart = [];
  int removeDuplications() {
    distinctedCart = karta.toSet().toList();
    return distinctedCart.length;
  }

  @override
  Widget build(BuildContext context) {
    karta.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });
    print(karta);

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
            children: List.generate(removeDuplications(), (index) {
          bool isChecked = true;
          int productQuantity = 1;
          var item = widget.rows?[karta[index]];

          print('object');

          print('nr-> $index, ilość produktu-> ${map[index]}');

          // map.toString();

          //03 42

          // while (countin.length > distinctedCart.length) {
          //   if (countin.contains(karta[index])) {
          //     countin.removeAt(index);
          //     setState(() {
          //       ++productQuantity;
          //     });
          //   }
          // }

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
                      size: 32,
                      color: Colors.white,
                    )),
                Expanded(
                    child: Text(item[1].toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.overpass(color: Colors.white))),
                Text(
                  'Ilość : $productQuantity',
                  style: GoogleFonts.overpass(color: Colors.white),
                ),
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
        }))
      ],
    )));
  }
}
