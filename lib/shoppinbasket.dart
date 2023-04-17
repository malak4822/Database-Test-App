import 'package:databaseapp/shoplist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppIngBasket extends StatefulWidget {
  const ShoppIngBasket({super.key, this.rows});
  final List<List>? rows;

  @override
  State<ShoppIngBasket> createState() => _ShoppIngBasketState();
}

class _ShoppIngBasketState extends State<ShoppIngBasket> {
  void deleteProduct(int ind) {
    setState(() {
      karta.remove(karta[ind]);
    });
    print(karta);
  }

  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: ListView(
          children: [
            Column(
                children: List.generate(karta.length, (index) {
              var item = widget.rows?[karta[index]];

              print(item);

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 120,
                color: const Color.fromARGB(255, 110, 110, 110),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(image: NetworkImage(item![0].toString())),
                    IconButton(
                        onPressed: () {
                          deleteProduct(index);
                        },
                        //  pink    jablko     gorczanek      pink whner    norma yost
                        icon: const Icon(
                          Icons.restore_from_trash_rounded,
                          size: 36,
                          color: Colors.white,
                        )),
                    Text(item[1].toString()),
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
