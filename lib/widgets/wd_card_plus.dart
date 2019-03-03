import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:event_bus/event_bus.dart';
import '../common/eventBus.dart';
import 'dart:convert';

class WdCardPlus extends StatefulWidget {
  @override
  _WdCardStatePlus createState() => _WdCardStatePlus();
}
class _WdCardStatePlus extends State<WdCardPlus> {
  bool _hasData;
  bool changed;
  String data;
  var result;
  Color fromColor;
  Color toColor;
  List<String> _sns;
  List gets;
  Map<int,List<String>> binds;


//获取温度计
    _getBind()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      gets = prefs.getStringList("bind")??[];
      binds={};
      print(gets);
      if(gets.isEmpty){_hasData=false;return;}
      _hasData=true;
  for(int i = 0;i<gets.length;i++){
    binds[i]=[json.decode(gets[i])[0],json.decode(gets[i])[1]];
  }
      print(binds);
      _sns=[];
      for(int i=0;i<binds.length;i++){
          _sns.insert(i, binds[i][0]);
      }
      getData(_sns);
    }

    getData(List list) async{
    String snsStr="";
    var httpClient = new HttpClient();
    RegExp _isSn = new RegExp(r"^[a-z0-9]{4,7}$");
    for(int i=0;i<list.length;i++){if(_isSn.hasMatch(list[i])){if(i==0)snsStr=snsStr+list[i];else snsStr=snsStr+"-"+list[i];}}
    print(snsStr);
    String url = "https://temp2.wf163.com:1443/wendu/now_wendu.php?sn="+snsStr;
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if(response.statusCode == HttpStatus.OK){
      var json = await response.transform(utf8.decoder).join();
    if(!mounted)return;
      result=jsonDecode(json);
    setState(() {
      });
    }else{
      
    }
    }
  List wdData;
  @override
  initState() {
    eventBus.on<MyEvent>().listen((MyEvent event){_getBind();});
    super.initState();
    _hasData=false;
    // widget.data.addListener(_handleValueChanged);
    _getBind();
  }
@override
  void dispose() {
    // widget.data.removeListener(_loadSns);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // print(result);
      return _hasData?ListView.builder(
        itemCount: result.length*2-1,
        padding: EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context,int index){
          if(index.isEven)
          return Card(
            color: Colors.grey[200],
            child: 
            FlatButton(
              onPressed: (){},
            child:
            Column(
              children:<Widget>[
                Container(
                  alignment:FractionalOffset.topLeft,
                  margin: EdgeInsets.only(top:7.0,left: 10.0),
                  child: 
                  Row(
                    children:<Widget>[
                    Text(
                      "·"+binds[index~/2][1],
                      style:
                      TextStyle(
                        color:Colors.blueGrey[400],
                        fontSize: 25.0,
                        height: 1.5
                      )
                    ),
                    ],
                  ),
                ),
                Container(
                  alignment: FractionalOffset.topLeft,
                  // height:150.0,
                  width:300.0,
                  child:
                  Row(
                    children:<Widget>[
                      Container(
                        alignment: FractionalOffset.topLeft,
                        child:
                        Text(
                          result[index~/2]["wendu"],
                          style:TextStyle(
                            color: Color(0xff727272),
                            fontSize:55.0,
                            letterSpacing: 5.0  
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                        child:
                        Text(
                          "℃",
                          style:TextStyle(
                            color: Color(0xC8F44336),
                            fontSize:30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0  
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0 , 0.0, 0.0, 0.0),
                  alignment: FractionalOffset.topLeft,
                  child:
                  Text(
                    "最后测量时间: ${result[index~/2]["mm"]}-${result[index~/2]["dd"]} ${result[index~/2]["day"]}",
                    style: TextStyle(color:Color(0xff8b00b8),fontSize:14.0),
                  ),
                ),
                Container(
                  alignment: FractionalOffset.bottomRight,
                  // margin: EdgeInsets.only(top: 10.0),
                  child:
                  IconButton(
                    icon: Icon(Icons.more_horiz,color:Colors.grey),
                    onPressed: (){_getBind();},
                    iconSize: 30,
                  ),
                ),
                ],
              ),
            ),
            );
            else
            return
    SizedBox(
      height: 10,
      child: Center(
        child: Container(
          height: 0.0,
          margin: EdgeInsetsDirectional.only(start: 0.0),
          decoration: BoxDecoration(
            border: Border(
              bottom:  BorderSide(
      color: Colors.grey[600],
      width: 0.0,
      ),
            ),
          ),
        ),
      ),
    );
        },
    ):
      Container(
        margin: EdgeInsets.only(top:200),
        child:Column(
          children: <Widget>[
            Text("点击\"+\"添加一个温度计",style: TextStyle(color:Colors.grey),),
            IconButton(icon: Icon(Icons.add),onPressed: (){Navigator.pushNamed(context, "addname");},iconSize: 25,)
          ],
        )
    );
  }
}