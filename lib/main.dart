import 'package:flutter/material.dart';
import 'pages/homepagePlus.dart';
import 'routes/addName.dart';
import 'routes/bind_manage.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'wxtest.dart';
import 'routes/loginpage/login.dart';
import 'routes/loginpage/register.dart';

void main() {
  debugPaintSizeEnabled = false;      //打开视觉调试开关
  runApp(new MyApp());
}
class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  _initFluwx() async{
  await fluwx.register(appId: "wx65d72c06628dcf6a",doOnAndroid: true,doOnIOS: true,enableMTA: false);
  var result =await fluwx.isWeChatInstalled();
  print("_initFluwx():is installed $result");
}

void initState() { 
  super.initState();
//  _initFluwx();
}
  Future<void> initPlatformState() async {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wendu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePagePlus(),
      routes: {
        "home":(BuildContext context)=>new MyApp(),
        "options":(BuildContext context)=>new BindManage(),
        "addname":(BuildContext context)=>new AddName(),
        "wxtest":(BuildContext context)=>new SendAuthPage(),
        "login":(BuildContext context)=>new Login(),
        "register":(BuildContext context)=>new Register()
      },
    );
  }
}