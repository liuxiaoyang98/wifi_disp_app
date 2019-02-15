import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget{
  @override
  _SettingsState createState()=>_SettingsState();
}
class _SettingsState extends State<Settings>{  
    final TextEditingController defSn= new TextEditingController();
  Widget build(BuildContext context){
    //默认设备textField controller
      return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _saveSettings,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
             FlatButton(
               onPressed: (){Navigator.pushNamed(context, "addname");},
               child: Container(
                 alignment: FractionalOffset.centerLeft,
                 padding: EdgeInsets.all(8.0),
                 height: 50,
                 child:
                 Text("添加备注",
                 style: TextStyle(
                   fontSize: 22,
                   color: Color(0xA0000000),
                 ),),),
             ),
              /*
              child:
              Row(
                children:<Widget>[
                Expanded(child: 
                Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  child:
                TextField(
                  cursorWidth: 2.0,
                  controller: defSn,
                  maxLength: 8,
                  style: TextStyle(fontSize: 18.0,color: Colors.black87),
                  decoration: InputDecoration(
                    helperText: "设置设备号备注",
                    labelText: "输入默认设备编号",
                    border: InputBorder.none,
                    prefix:Text(" Sn:  ",style: TextStyle(color:Colors.blue,fontSize:18.0,fontWeight: FontWeight.bold),),
                    suffixIcon:IconButton(onPressed: _snDel,icon: Icon(Icons.close),),
                  )
                ),),),
                ],
              ),*/

             Divider(),
             FlatButton(
               onPressed: (){Navigator.pushNamed(context, "delname");},
               child: Container(
                 alignment: FractionalOffset.centerLeft,
                 padding: EdgeInsets.all(8.0),
                 height: 50,
                 child:
                 Text("删除备份",
                 style: TextStyle(
                   fontSize: 22,
                   color: Color(0xA0000000),
                 ),),),
             ),

             Divider(),
             FlatButton(
               onPressed: (){_clear();},
               child: Container(
                 alignment: FractionalOffset.centerLeft,
                 padding: EdgeInsets.all(8.0),
                 height: 50,
                 child:
                 Text("清空其他编号",
                 style: TextStyle(
                   fontSize: 22,
                   color: Color(0xA0000000),
                 ),),),
             ),
          ],
        ),
      ),
    );
  }
  _saveSettings()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _saveSn = defSn.text;
    prefs.setString("SN", _saveSn);
    // Navigator.pop(context,_saveSn);
  }
  _snDel(){//清空输入框
    defSn.text="";
  }
}
  _clear()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("SNS");
    prefs.remove("bind");
  }