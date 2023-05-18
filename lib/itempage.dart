import 'package:databaseapp/main.dart';
import 'package:databaseapp/shoplist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemPage extends StatefulWidget {
  const ItemPage(
      {super.key,
      required this.id,
      required this.myRows,
      this.backFromBuyMore});
  final Function? backFromBuyMore;
  final int id;
  final List<List> myRows;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int itemsNumber = 1;

  void saveBasketItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> kartaString = karta.map((e) => e.toString()).toList();
    prefs.setStringList('basketNumbers', kartaString);
  }

  void incr() {
    setState(() {
      ++itemsNumber;
    });
  }

  void decr() {
    if (itemsNumber == 1) {
    } else {
      setState(() {
        --itemsNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var images = widget.myRows[widget.id][0].toString();
    var names = widget.myRows[widget.id][1].toString();

    void addProduct() {
      for (int i = 0; i < itemsNumber; ++i) {
        karta.add(widget.id);
      }
    }

    void showAlert() {
      showDialog(
        context: context,
        builder: (context) {
          return Stack(
            children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(color: Colors.white, height: 120)),
              AlertDialog(
                elevation: 0,
                alignment: Alignment.bottomCenter,
                insetPadding: const EdgeInsets.only(bottom: 0),
                actionsPadding: const EdgeInsets.fromLTRB(0, 80, 0, 50),
                shape: const CircleBorder(eccentricity: 1),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actionsOverflowAlignment: OverflowBarAlignment.center,
                actions: [
                  // Switch(value: value, onChanged: onChanged)
                  if (itemsNumber == 1)
                    Text(
                      'Dodano do koszyka',
                      style: GoogleFonts.overpass(fontSize: 22),
                    ),
                  if (itemsNumber > 1 && itemsNumber < 5)
                    Text(
                      'Dodano do koszyka $itemsNumber produkty',
                      style: GoogleFonts.overpass(fontSize: 22),
                    ),
                  if (itemsNumber > 4)
                    Text(
                      'Dodano do koszyka $itemsNumber produktów',
                      style: GoogleFonts.overpass(fontSize: 22),
                    ),
                  ElevatedButton(
                      onPressed: () {
                        widget.backFromBuyMore!();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyHomePage(row: widget.myRows)));
                      },
                      child: const Text('Przejdź Do Zakupu')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Kupuj dalej'))
                ],
              )
            ],
          );
          ;
        },
      );
    }

    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.insert_emoticon,
            size: 50,
            color: Colors.black,
          ),
          Text(widget.id.toString()),
          Text(names,
              style: GoogleFonts.overpass(fontSize: 40, color: Colors.black)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 1 / 2),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20)),
                      onPressed: () {
                        addProduct();
                        saveBasketItems();
                        showAlert();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.shopping_basket_outlined,
                            size: 28,
                          ),
                          Text(
                            'Add To Basket',
                            style: GoogleFonts.overpass(fontSize: 20),
                          )
                        ],
                      ))),
              Text(itemsNumber.toString(),
                  style: GoogleFonts.overpass(fontSize: 26)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black45,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => incr(),
                        icon: const Icon(Icons.plus_one,
                            color: Colors.white, size: 24)),
                    IconButton(
                        onPressed: () => decr(),
                        icon: const Icon(
                          Icons.exposure_minus_1,
                          color: Colors.white,
                          size: 24,
                        ))
                  ],
                ),
              )
            ],
          )
        ])));
  }
}
