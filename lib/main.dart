import 'package:databaseapp/card.dart';
import 'package:databaseapp/shoplist.dart';
import 'package:databaseapp/settings.dart';
import 'package:flutter/material.dart';
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

final List<Map<String, dynamic>> _rows = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future showRecords() async {
  wynik = await connection.query('SELECT * FROM thumbnailContent');
  for (var row in wynik) {
    final map = {
      'id': row[0],
      'thumbnailURL': row[1],
      'author': row[2],
    };
    _rows.add(map);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
    showRecords();
  }

  List<Widget> screens = [
    MyShop(myRows: _rows),
    const MyCard(),
    const MySettings(),
  ];
  int selectedIndex = 0;

  changeindex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: changeindex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.production_quantity_limits), label: 'items'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard), label: 'card'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'settings')
            ]),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: screens.elementAt(selectedIndex));
  }
}
