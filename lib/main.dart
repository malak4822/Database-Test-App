import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

late MySqlConnection connection;
var wynik;
void main() async {
  try {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'hosting2338925.online.pro',
        port: 3306,
        user: '00799458_f155c735',
        password: 'Rm31Uc8RHwr62aF',
        db: '00799458_f155c735'));
    connection = conn;
  } catch (e) {
    print('error to $e');
  }

  runApp(const MyApp());
}

List<Map<String, dynamic>> _rows = [];

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

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    showRecords();
    super.initState();
  }

  Future showRecords() async {
    wynik = await connection.query('SELECT * FROM boys');
    for (var row in wynik) {
      final map = {
        'id': row[0],
        'name': row[1],
        'email': row[2],
      };
      _rows.add(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _rows.length,
          itemBuilder: (context, index) {
            final row = _rows[index];
            return ListTile(
              title: Text(row['name']),
              subtitle: Text(row['email']),
            );
          },
        ),
      ),
    );
  }
}
