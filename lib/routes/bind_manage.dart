import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BindManage extends StatefulWidget {
  _BindManageState createState() => _BindManageState();
}

class _BindManageState extends State<BindManage> {
final TextEditingController defsn = new TextEditingController();
final TextEditingController defname = new TextEditingController();
  List<bool>textfld;
  List gets;
  bool _hasData;
  Map<int,List<String>> binds;

  _getBind()async{
    
  SharedPreferences prefs = await SharedPreferences.getInstance();
  gets = prefs.getStringList("bind")??[];
  binds={};
  if(gets.isEmpty){
    _hasData=false;print("List is null");
    return;
  }
  for(int i = 0;i<gets.length;i++){
  textfld.add(false);
    binds[i]=[json.decode(gets[i])[0],json.decode(gets[i])[1]];
  }
  print(binds);
    if(!_hasData){
    _hasData=true;
    setState(() {});
    }
    // setState(() {});
  }


  void _bindNickname2sn(int index)async{
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
    
    bind[index]=jsonEncode([sn,name]);
    print(bind);
    prefs.setStringList("bind", bind);
    _getBind();
    setState(() {});
  }


  @override
  void initState() {
    _hasData=false;textfld=[];
    _getBind();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    
    super.dispose();
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
  Widget build(BuildContext context) {
    return _hasData?Scaffold(
    appBar: AppBar(title: Text("管理温度计"),actions: <Widget>[
      IconButton(icon:Icon(Icons.settings),onPressed: (){}),
      IconButton(icon: Icon(Icons.add),onPressed: (){Navigator.pushNamed(context, "addname");},),
    ],),
    body:ListView.builder(
      itemCount:binds.length,
      itemBuilder: (BuildContext context,int index){
        return GestureDetector(

          onTap: (){setState(() {textfld[index]=true;});},
          child:
          Container(decoration: BoxDecoration(),
            child:
        Row(
          children: <Widget>[
            Text("disp_",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20),),
            Container(
              width: 85,
              margin: EdgeInsets.only(left: 7),
              child:textfld[index]?
              TextField(
                controller: defsn,
                decoration: InputDecoration(
                  hintText: binds[index][0],
                  hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey
              )
                ),
              )
              :
            Text(binds[index][0]+":",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            ),
            ),
            Expanded(child:
            Container(
              margin: EdgeInsets.only(left: 7),
              child:textfld[index]?
              TextField(
                controller: defname,
                decoration: InputDecoration(
                  hintText: binds[index][1],
                  hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey
              )
                ),
              ):
            Text(binds[index][1],
            style: TextStyle(
              fontSize: 21
            ),),),),
            textfld[index]?
            IconButton(
              icon:Icon(Icons.done),
              onPressed:(){setState(() {textfld[index]=false;});_bindNickname2sn(index);},)
            :IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){_del(binds[index][0]);},
            ),
          ],),)
        );
      },
    ),
    ):Scaffold(
    appBar: AppBar(title: Text("删除备份"),actions: <Widget>[
      IconButton(icon: Icon(Icons.add),onPressed: (){Navigator.pushNamed(context, "addname");},),
    ],),
    body:Center(
      child: Text("点击右上角'+'添加一个温度计"),
    )
    );}
            }