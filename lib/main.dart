import 'package:flutter/material.dart';
import 'pages/homepagePlus.dart';
import 'routes/settings.dart';
import 'routes/addName.dart';
import 'routes/delName.dart';
import 'routes/bind_manage.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;


void main() {
  debugPaintSizeEnabled = false;      //打开视觉调试开关
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wendu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePagePlus(),
      routes: {
        "options":(BuildContext context)=>new BindManage(),
        "addname":(BuildContext context)=>new AddName(),
      },
    );
  }
}
