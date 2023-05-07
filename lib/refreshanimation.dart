import 'dart:async';
import 'package:databaseapp/shoplist.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

Future<void> handleRefresh() {
  print(time);
  final Completer<void> completer = Completer<void>();
  Timer(time, () {
    completer.complete();
  });

  return completer.future.then<void>((_) {
    ScaffoldMessenger.of(scaffoldKey.currentState!.context).showSnackBar(
      const SnackBar(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        content: Text('Refresh complete'),
      ),
    );
  });
}
