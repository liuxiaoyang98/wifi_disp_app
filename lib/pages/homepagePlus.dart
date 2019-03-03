import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';
import '../widgets/wd_card_plus.dart';
import '../widgets/drawer.dart';
//import 'package:fluwx/fluwx.dart' as fluwx;

class HomePagePlus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                Navigator.pushNamed(context, "login");} ,
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
        child:WdCardPlus()
      ),
      drawer: Drawers(),
    );
  }
}