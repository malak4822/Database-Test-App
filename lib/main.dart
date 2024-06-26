import 'package:databaseapp/bloc/counter_bloc.dart';
import 'package:databaseapp/card.dart';
import 'package:databaseapp/shoplist.dart';
import 'package:databaseapp/settings.dart';
import 'package:databaseapp/shoppinbasket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysql1/mysql1.dart';

late MySqlConnection connection;
var wynik;
void main() async {
  try {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'hosting2338925.online.pro',
        port: 3306,
        user: '00799458_malakdb',
        password: 'Rm31Uc8RHwr62aF',
        db: '00799458_malakdb'));
    connection = conn;
  } catch (e) {
    print('error to $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CounterBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, this.title, this.row});

  final List<List>? row;
  final String? title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int currentIndex = 0;

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> screens = [
    MyShop(),
    const MyCard(),
    MySettings(),
  ];
  int selectedIndex = 0;

  changeindex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var sklep = const MyShop();
    var row = sklep.getRows;

    List<Widget> screens = [
      const MyShop(),
      ShoppIngBasket(rows: row),
      MySettings(),
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: changeindex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.production_quantity_limits), label: 'Shop'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard), label: 'My Card'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Account')
            ]),
        appBar: AppBar(
          title: Text(widget.title ?? 'Flutter Demo'),
        ),
        body: screens.elementAt(currentIndex));
  }
}
