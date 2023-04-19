import 'package:databaseapp/main.dart';
import 'package:databaseapp/shoplist.dart';
import 'package:databaseapp/shoppinbasket.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key, required this.id, required this.myRows});
  final int id;
  final List<List> myRows;

  @override
  Widget build(BuildContext context) {
    var images = myRows[id][0].toString();
    var names = myRows[id][1].toString();

    addProduct() {
      if (!karta.contains(id)) {
        karta.add(id);
      }
    }

    void showAlert() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              const Text('Dodano Do Koszyka'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShoppIngBasket(
                                  rows: myRows,
                                )));
                  },
                  child: const Text('Przejdź Do Zakupu')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Kupuj dalej'))
            ],
          );
          ;
        },
      );
    }

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
              Text(id.toString()),
              Text(
                names,
                style: GoogleFonts.overpass(fontSize: 40, color: Colors.black),
              ),
              Image.network(images,
                  loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const CircularProgressIndicator();
                }
              }),
              const Divider(
                  color: Colors.black,
                  height: 20,
                  indent: 30,
                  endIndent: 30,
                  thickness: 1),
              ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 3 / 4),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20)),
                      onPressed: () {
                        addProduct();
                        showAlert();
                        print(karta);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.shopping_basket_outlined,
                            size: 32,
                          ),
                          Text(
                            'Add To Basket',
                            style: GoogleFonts.overpass(fontSize: 24),
                          )
                        ],
                      )))
            ],
          ),
        ));
  }
}
