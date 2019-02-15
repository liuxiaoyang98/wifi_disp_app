import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class DelName extends StatefulWidget {
  _DelNameState createState() => _DelNameState();
}

class _DelNameState extends State<DelName> {
  List gets;
  bool _hasData;
  Map<int,List<String>> binds;

//获取保存在本地的温度计名称
  _getBind()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  gets = prefs.getStringList("bind")??[];
  binds={};
  print(gets);
  if(gets.isEmpty){
    _hasData=false;print("List is null");
    return;
  }
  for(int i = 0;i<gets.length;i++){
    binds[i]=[json.decode(gets[i])[0],json.decode(gets[i])[1]];
  }
  print(binds);
    if(!_hasData){
    _hasData=true;
    setState(() {});
    }
  }

  //初始化
  @override
  void initState() {
    _hasData=false;
    _getBind();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _hasData?Scaffold(
    appBar: AppBar(title: Text("删除备份"),),
    body:ListView.builder(
      itemCount:binds.length,

      itemBuilder: (BuildContext context,int index){
        return Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 7),
              child: 
            Text(_hasData?"disp_"+binds[index][0]+":":"",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
            ),
            ),
            Expanded(child:
            Container(
              margin: EdgeInsets.only(left: 7),
              child:
            Text(_hasData?binds[index][1]:"没有任何备注",
            style: TextStyle(
              fontSize: 21
            ),),),),
            _hasData?IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){_del(binds[index][0]);},
            ):Container()
          ],
        );
      },
    ),
    ):Scaffold(
    appBar: AppBar(title: Text("删除备份"),),
    body:Center(
      child: Text("点击右上角'+'添加一个温度计"),
    )
    );
  }
  _del(String sn)async{
    print(sn);
  SharedPreferences prefs = await SharedPreferences.getInstance();
    for(int i=0;i<binds.length;i++){
      if(binds[i][0]==sn){
        print(i);
        gets.removeAt(i);
        binds.remove(i);
      }
      print(binds);
    }
    print(gets);
    prefs.setStringList("bind", gets);
    setState(() {});
  }
}