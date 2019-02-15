import 'package:flutter/material.dart';
class Drawers extends StatefulWidget{
  @override
  _DrawersState createState()=>_DrawersState();
}
class _DrawersState extends State<Drawers>{
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("温度查询APP"),
            accountEmail: Text("感谢使用"),
            currentAccountPicture: new GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.blue[200],
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