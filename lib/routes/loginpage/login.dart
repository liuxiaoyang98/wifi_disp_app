import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: (){Navigator.pop(context);dispose();},
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:13),
            alignment: FractionalOffset.topCenter,
            child:
            Row(
              children:<Widget>[
                Text("用户名:"),
                Container(
                  width: 200,
                  child:
                TextField(
                  controller: _username, 
                ),),
              ]),),
Container(
            margin: EdgeInsets.only(top:13),
            alignment: FractionalOffset.topCenter,
            child:
            Row(
              children:<Widget>[
                Text("密码:  "),
                Container(
                  width: 200,
                  child:
                TextField(
                  controller: _password, 
                ),),
              ]),),
              Row(children: <Widget>[
                Text("没有账号请"),
                FlatButton(
                  onPressed: (){Navigator.pushNamed(context, "register");dispose();},
                  child: Text("注册",style: TextStyle(color:Colors.blue),),
                )
              ],),
              FlatButton(
                color: Colors.blue[300],
                onPressed: (){print("login");},
                child: Text("登录"),
              )
          ],
        ),
      ),
    );
  }
}