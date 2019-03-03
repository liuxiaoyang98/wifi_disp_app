import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  


  @override
  void dispose() { 
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: (){Navigator.pop(context);dispose();},
          )
        ],
      ),
      body: Container(
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
                Text("已有账号请"),
                FlatButton(
                  onPressed: (){Navigator.pushNamed(context, "login");},
                  child: Text("登录",style: TextStyle(color:Colors.blue),),
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