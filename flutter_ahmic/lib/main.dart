import 'package:flutter/material.dart';
import 'package:flutter_ahmic/ui/listpage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: ListPage(title: 'Ide Proposal'),
    );
  }
}
