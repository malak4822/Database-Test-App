import 'package:databaseapp/refreshanimation.dart';
import 'package:databaseapp/shoplist.dart';
import 'package:databaseapp/settings.dart';
import 'package:databaseapp/shoppinbasket.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

var wynik;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    ConnectionSettings connData = ConnectionSettings(
        host: 'hosting2338925.online.pro',
        port: 3306,
        user: '00799458_malakdb',
        password: 'Rm31Uc8RHwr62aF',
        db: '00799458_malakdb');
    final conn = await MySqlConnection.connect(connData).then((val) {
      MyShopState().fillProductsList(val);
    });
  } catch (e) {
    print('error to $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, this.title, this.row});

  final List<List>? row;
  final String? title;
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  void changeIndexx() {
    setState(() {
      currentIndex = 1;
    });
  }

  int currentIndex = 0;

  changeindex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var sklep = MyShop();
    var row = sklep.getRows;
    List<Widget> screens = [
      MyShop(backFromBuyMore: changeIndexx),
      ShoppIngBasket(rows: row),
      const MySettings(),
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
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
          title: Text(widget.title ?? 'Flutter Demo'),
        ),
        body: screens.elementAt(currentIndex));
  }
}
