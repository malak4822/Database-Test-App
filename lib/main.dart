import 'package:databaseapp/refreshanimation.dart';
import 'package:databaseapp/shoplist.dart';
import 'package:databaseapp/settings.dart';
import 'package:databaseapp/shoppinbasket.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

late MySqlConnection connection;
var wynik;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  MyHomePage({super.key, this.title, this.products});

  final List<List>? products;
  final String? title;
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

int currentIndex = 0;

class MyHomePageState extends State<MyHomePage> {
  changeindex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const MyShop(),
      ShoppIngBasket(products: widget.products!),
      const MySettings(),
    ];
    return Scaffold(
        key: scaffoldKey,
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
