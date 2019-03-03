import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../common/eventBus.dart';

void fireRefresh(){
  eventBus.fire(new MyEvent("added"));
}

class AddName extends StatefulWidget {
  _AddNameState createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
final TextEditingController defsn = new TextEditingController();
final TextEditingController defname = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("添加一个温度计"),
      actions: <Widget>[
        IconButton(
          icon:Icon(Icons.done),
          onPressed: (){_bindNickname2sn();fireRefresh();Navigator.pushNamed(context, "options");},
        )
      ],
    ),
    body:Container(
       child:
       Column(
         children: <Widget>[
          Container(//副标题
            margin: EdgeInsets.only(top:13),
            alignment: FractionalOffset.topCenter,
            child:
            Text("将设备号添加备注,并始终显示在首页",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[850]
              ),),),

          Container(
            margin: EdgeInsets.only(top: 13,left: 13),
            child:
          Row(
            children: <Widget>[
                Expanded(child: 
                Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  child:
                TextField(
                  cursorWidth: 2.0,
                  controller: defsn,
                  maxLength: 8,
                  style: TextStyle(fontSize: 27.0,color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: "输入设备编号",
                    labelStyle: TextStyle(fontSize: 18),
                    border: InputBorder.none,
                    prefix:Text(" disp_",style: TextStyle(color:Colors.blue,fontSize:18.0,fontWeight: FontWeight.bold),),
                    suffixIcon:IconButton(onPressed: _snDel,icon: Icon(Icons.close),),
                  )
                ),),),
            ],
          ),
          ),

          Container(
            margin: EdgeInsets.only(top: 13,left: 13),
            child:
          Row(
            children: <Widget>[
                Expanded(child: 
                Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  child:
                TextField(
                  cursorWidth: 2.0,
                  controller: defname,
                  maxLength: 8,
                  style: TextStyle(fontSize: 27.0,color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: "输入备注名称",
                    labelStyle: TextStyle(fontSize: 18),
                    border: InputBorder.none,
                    prefix:Text("备注:  ",style: TextStyle(color:Colors.blue,fontSize:18.0,fontWeight: FontWeight.bold),),
                    suffixIcon:IconButton(onPressed: _nameDel,icon: Icon(Icons.close),),
                  )
                ),),),
            ],
          ),
          ),
         ],
       ),
    ),
    );
  }
  void _bindNickname2sn()async{
    String sn=defsn.text;if(sn.isEmpty)return;
    RegExp _isSn = new RegExp(r"^[a-z0-9]{4,7}$");
    if(!_isSn.hasMatch(sn))return;
    String name=defname.text;if(name.isEmpty)return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bind = prefs.getStringList("bind")??[];
    print(bind);
    for(String v in bind){
      if(jsonDecode(v)[0]==sn||jsonDecode(v)[1]==name)return;
    }
    
    bind.insert(bind.length,jsonEncode([sn,name]));
    print(bind);
    prefs.setStringList("bind", bind);
    //prefs.remove("bind");
  }

  void _showSnack(){
    final snackBar = new SnackBar(content: Text("Success"));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _snDel(){//清空输入框
    defsn.text="";
  }
  _nameDel(){//清空输入框
    defname.text="";
  }
}