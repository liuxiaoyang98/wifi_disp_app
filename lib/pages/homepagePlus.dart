import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';
import '../widgets/wd_card_plus.dart';
import '../widgets/drawer.dart';

class HomePagePlus extends StatefulWidget {
  _HomePagePlusState createState() => _HomePagePlusState();
}

class _HomePagePlusState extends State<HomePagePlus>  with SingleTickerProviderStateMixin {
  var data;
  var result;
  Color fromColor;
  Color toColor;
  Map <int,List<Map<String, String>>> cardData;
  // ValueNotifierData vd;

  _clear()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("SNS");
  }
  clearSave(String key)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  Animation<double> tween;
  AnimationController controller;

  var appWidth=0.0;
  var strWidth;
  initState(){
    // vd = ValueNotifierData(['Hello']);
    fromColor=Colors.white;
    toColor=Colors.white;
    super.initState();
    controller = new AnimationController(
      duration: const Duration(milliseconds: 600),vsync: this);
      tween = new Tween(begin: 0.0,end: 10.0).animate(controller)..addListener((){
        setState(() {
                });
      });
  }

  startAnimation(double from){
    setState(() {
          controller.forward(from: 0.0);
        });
  }




  final TextEditingController textField = new TextEditingController();
  bool hasResult;
  @override
  Widget build(BuildContext context) {
    if(null==result)hasResult=false;else hasResult=true;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        /// NAME       SIZE   WEIGHT   SPACING  2018 NAME
        /// title      20.0   medium   0.0      headline6
        title:Text("我的温度计"),
        backgroundColor: Colors.blue,
        actions: <Widget>[PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz),
          itemBuilder: (BuildContext context)=><PopupMenuItem<String>>[ 
            new PopupMenuItem(
              value:"settings",child:
              FlatButton(
                child: Text("设置",style: TextStyle(fontSize: 22.0,color: Colors.black87),),
                padding: EdgeInsets.all(0),
                onPressed:(){
                Navigator.pop(context);
                Navigator.pushNamed(context, "options");} ,
              )
              ),
            new PopupMenuItem(
              value: "222222",
              child:
              FlatButton(
                child: Text("设置",style: TextStyle(fontSize: 22.0,color: Colors.black87),),
                padding: EdgeInsets.all(0),
                onPressed:(){
                Navigator.pop(context);
                Navigator.pushNamed(context, "options");} ,
              ),
              ),
            new PopupMenuItem(
              value: "33333",
              child:
              FlatButton(
                child: Text("设置",style: TextStyle(fontSize: 22.0,color: Colors.black87),),
                padding: EdgeInsets.all(0),
                onPressed:(){
                Navigator.pop(context);
                Navigator.pushNamed(context, "options");} ,
              )
              ),
          ]
          ),
          
        ],
      ),
      body:
      Center(
        // child:hasResult?loops:WdCard(wdData:result),
        child:WdCardPlus()
      ),
      drawer: Drawers(),
    );
  }
@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}