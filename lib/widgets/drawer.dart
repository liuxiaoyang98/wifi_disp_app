import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:shared_preferences/shared_preferences.dart';

class Drawers extends StatefulWidget{
  @override
  _DrawersState createState()=>_DrawersState();
}
class _DrawersState extends State<Drawers>{
  bool _haslogin;
  String _result="无";
  _checkLogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _uData = prefs.getString("userdata")??"";
    if(!_uData.isEmpty){
      _haslogin=true;
    }else{
      _haslogin=false;
    }
    print("_checkLogin:_hasLogin=$_haslogin");
  }
  void initState() { 
    super.initState();
    _haslogin=false;
    _checkLogin();
    fluwx.responseFromAuth.listen((data) {
      setState(() {
        _result = "${data.errCode}";
      });
    });
  }
  _sendAuth(){
    fluwx.sendAuth(scope: "snsapi_userinfo",state:"wechat_sdk_demo_test")
    .then((data){
      print("data:$data");
    });
  }
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration:BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        margin: EdgeInsets.all(0),
        padding: const EdgeInsetsDirectional.only(top: 16.0, start: 16.0),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child:
                Container(
                  alignment: FractionalOffset.center,
                  padding: EdgeInsets.only(right: 55),
                child: Text("尚未登录请'登录'或'注册'",style: TextStyle(color:Colors.lightBlue[100]),),
              ),
              ),
              Row(
                children: <Widget>[
              RaisedButton(
                onPressed: (){Navigator.pop(context);Navigator.pushNamed(context, "login");},
                color: Colors.lightBlueAccent[200],
                child: Text("登录",style: TextStyle(color:Colors.white),),
              ),
              Container(
                width: 40,
              ),
              RaisedButton(
                onPressed: (){Navigator.pop(context);Navigator.pushNamed(context, "register");},
                color:Colors.lightBlueAccent[200],
                child:Text("注册",style: TextStyle(color: Colors.white),),
                )
                ],
              ),
              Container(
                height:20
              )
            ],
          ),
        ),
      ),
            ListTile(title: Text('设置',style: TextStyle(fontSize: 22.0,color: Colors.black87),),
              trailing: new Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "options");
              },),
              Divider(),
            ListTile(title: Text('关于',style: TextStyle(fontSize: 22.0,color: Colors.black87),),
              trailing:Icon(Icons.more_horiz),
              onTap: () {
                Navigator.pop(context);
              },
            ),
              Divider(),
        ],
      ),
    );
  }
}