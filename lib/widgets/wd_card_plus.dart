import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';
import 'dart:io';
import 'dart:convert';

// class ValueNotifierData extends ValueNotifier<List>{
//   ValueNotifierData(value):super(value);
// }
class WdCardPlus extends StatefulWidget {
  // WdCardPlus({this.data});
  // final ValueNotifierData data;
  @override
  _WdCardStatePlus createState() => _WdCardStatePlus();
}
class _WdCardStatePlus extends State<WdCardPlus> {
  bool _hasData;
  bool changed;
  String data;
  var switchColor;
  var result;
  Color fromColor;
  Color toColor;
  List<String> _sns;
  List gets;
  Map<int,List<String>> binds;
    _getBind()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      gets = prefs.getStringList("bind")??[];
      binds={};
      print(gets);
  for(int i = 0;i<gets.length;i++){
    binds[i]=[json.decode(gets[i])[0],json.decode(gets[i])[1]];
  }
      print(binds);
      List<String> ret=[];
      for(int i=0;i<binds.length;i++){
          ret.insert(i, binds[i][0]);
      }
      print(ret);
      prefs.setStringList("SNS", ret);
      _loadSns();
    }

    _loadSns() async{//读取'SNS'
    SharedPreferences prefs = await SharedPreferences.getInstance();
      _sns = prefs.getStringList("SNS")??["000000"];
      data=_sns.toString();
      getData(_sns);
  }
    bool _checkBind(int index){
      if(_sns.isEmpty)return false;
      String sn=_sns[index];
      for(int i=0;i<binds.length;i++){
        if(binds[i][0]==sn)return true;
      }
      return false;
    }
  //   void _handleValueChanged() {
  //   setState(() {
  //     print(widget.data.value);
  //   });
  // }
  _dataHasChanged()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _sns = prefs.getStringList("SNS")??["000000"];
    if(data!=_sns.toString())changed=true;
  }
  _removeSns(String sn)async{
    print(sn);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List sns = prefs.getStringList("SNS");
    sns.remove(sn);
    prefs.setStringList("SNS", sns);
  }
    getData(List list) async{
    String snsStr="";
    var httpClient = new HttpClient();
    RegExp _isSn = new RegExp(r"^[a-z0-9]{4,7}$");
    for(int i=0;i<list.length;i++){if(_isSn.hasMatch(list[i])){if(i==0)snsStr=snsStr+list[i];else snsStr=snsStr+"-"+list[i];}else _removeSns(list[i]);}
    print("77:"+snsStr);
    String url = "https://temp2.wf163.com:1443/wendu/now_wendu.php?sn="+snsStr;
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if(response.statusCode == HttpStatus.OK){
      var json = await response.transform(utf8.decoder).join();
    if(!mounted)return;
      result=jsonDecode(json);
    setState(() {
      _hasData=true;
      });
    }
    }
  Future<Null> loops() async{
    await Future.delayed(Duration(milliseconds: 500),(){
    _dataHasChanged();
    if(changed){
    _loadSns();
    changed=false;
    }
    loops();
    });
  }
  List wdData;
  @override
  initState() {
    super.initState();
    // widget.data.addListener(_handleValueChanged);
    _getBind();
    loops();
    _hasData=false;
    changed=false;
  }
@override
  void dispose() {
    // TODO: implement dispose
    // widget.data.removeListener(_loadSns);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // print(result);
    // print(_hasData?result.length*2-1:0);
      return ListView.builder(
        itemCount: _hasData?result.length*2-1:0,
        padding: EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context,int index){
          if(index.isEven)
          return Card(
            color: Colors.grey[200],
            /*
            margin: EdgeInsets.only(bottom: 2.0,top: 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.red[400],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                ),
              ],
              ),
              */
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
                      _checkBind(index~/2)?"·"+binds[index~/2][1]:"设备号:"+result[index~/2]["sn"],
                      style:_checkBind(index~/2)?
                      TextStyle(
                        color:Colors.blueGrey[400],
                        fontSize: 25.0,
                        height: 1.5
                      ):
                      TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize:20.0,
                      ),
                    ),
                    Expanded(child: 
                    Container(
                      height:20,
                      width:20,
                        padding: EdgeInsets.all(0.0),
                        margin: EdgeInsets.only(top: 25/2,bottom: 25/2),
                      alignment: FractionalOffset.topRight,
                        child:
                    _checkBind(index~/2)?Container():IconButton(
                        padding: EdgeInsets.all(0.0),
                      icon: Icon(Icons.close),
                      onPressed: (){_removeSns(_sns[index~/2]);},
                      iconSize: 20,
                      color: Color(0x66000000),
                    )
                    ),
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
                    onPressed: (){_loadSns();},
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
    );   
  }
}