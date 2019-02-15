import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';
import 'dart:io';
import 'dart:convert';
import '../widgets/wd_card.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin {
  var data;
  var switchColor;
  var result;
  Color fromColor;
  Color toColor;
  List<String> _sns;
  Map <int,List<Map<String, String>>> cardData;

  _loadSns() async{//读取'SNS'
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
         _sns = prefs.getStringList("SNS")??["000000"];
        getData(_sns);
        });
  }
  _removeSns(String sn)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List sns = prefs.getStringList("SNS");
    sns.remove(sn);
     prefs.setStringList("SNS", sns);
  }

  _snAutoSave(String sn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
          _sns = prefs.getStringList("SNS")??[];
           for(String v in _sns){
             if(v==sn)return;
           }
          _sns.insert(_sns.length, sn);
          prefs.setStringList("SNS", _sns);
        });
  }
  _clear()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("SNS");
  }
    getData(List list) async{
    var httpClient = new HttpClient();
    String json2list="";
    RegExp _isSn = new RegExp(r"^[a-z0-9]{4,7}$");
    int count=1;
    for(String v in list){
      if(_isSn.hasMatch(v)){
        String url = "https://temp2.wf163.com:1443/wendu/now_wendu.php?sn="+v;
          var request = await httpClient.getUrl(Uri.parse(url));
          var response = await request.close();
          if(response.statusCode == HttpStatus.OK){
            var json = await response.transform(utf8.decoder).join();
            //result = jsonDecode(json);
            if(count==1){
              json2list+="["+json.replaceAll(new RegExp(r"[\[\]]"),"");
            }else{
              json2list+=","+json.replaceAll(new RegExp(r"[\[\]]"),"");
            }
        }else{
          //result = 'Error getting Json data:status ${response.statusCode}';
        }
        if(!mounted)return;
        // cardData[count] = result;
        count++;
      }else{
      _removeSns(v);
    }
    }
    json2list+="]";
    setState(() {
    result=jsonDecode(json2list);
        });
    }
  
  clearSave(String key)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  Animation<double> tween;
  AnimationController controller;

  var appWidth=0.0;
  var strWidth;
  initState(){
    _loadSns();
    fromColor=Colors.white;
    toColor=Colors.white;
    super.initState();
    controller = new AnimationController(
      duration: const Duration(milliseconds: 600),vsync: this);
      tween = new Tween(begin: 0.0,end: 10.0).animate(controller)..addListener((){
        setState(() {
                });
      });
  }

  startAnimation(double from){
    setState(() {
          controller.forward(from: 0.0);
          
        });
  }

  //点击搜索按钮
  var _hasSearchBar=false;
  var fieldWidth = 0.0;
  var fieldHeight = 0.0;
  void clickSearch(){
    setState(() {
          if(_hasSearchBar){//已经有了搜索框->关闭
            if(textField.selection.baseOffset<=0);//空的话就啥都不干了
            else{
            _snAutoSave(textField.text).then(_loadSns());
            _hasSearchBar=false;
            fadeRGBO(Colors.white, Colors.blue, 1.0);
            }
          }else{//没有搜索框->打开
            fadeRGBO(Colors.blue, Colors.white, 1.0);
            _hasSearchBar=true;
          }
          // print(_sns);
        });
  }


//未完成（颜色渐变变化）
  void fadeRGBO(Color fromColor,Color toColor,double time){
        startAnimation(0);

        this.fromColor = fromColor;
        this.toColor = toColor;
        switchColor = fromColor;
  }


  final TextEditingController textField = new TextEditingController();
  bool hasResult;
  @override
  Widget build(BuildContext context) {
    if(null==switchColor){}else{//颜色渐变效果
        int r=(fromColor.red+(toColor.red-fromColor.red)*(tween.value/10)~/1);
        int g=(fromColor.green+(toColor.green-fromColor.green)*(tween.value/10)~/1);
        int b=(fromColor.blue+(toColor.blue-fromColor.blue)*(tween.value/10)~/1);
        switchColor=Color.fromRGBO(r, g, b, 1.0);
    }
    if(null==result)hasResult=false;else hasResult=true;
    return Scaffold(
      
      appBar: AppBar(
        /// NAME       SIZE   WEIGHT   SPACING  2018 NAME
        /// title      20.0   medium   0.0      headline6
        title: _hasSearchBar?TextField(
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color:Colors.black
          ),
          controller:textField,
          decoration: InputDecoration(
            hintText: "搜索设备",
            hintStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey,
            ),
          ),
        ):Text("温度查询"),

        backgroundColor: switchColor??Colors.blue,
        actions: <Widget>[
          IconButton(
            onPressed:_hasSearchBar?fieldClose:clickSearch,
            icon: _hasSearchBar?Icon(Icons.close,color: Colors.blueGrey,):Icon(Icons.search),
          ),
        ],
      ),
      body:Center(
        // child:hasResult?loops:WdCard(wdData:result),
        child:waitData()
      ),
      floatingActionButton: FloatingActionButton(
        // child: RotationTransition(child: Icon(_hasSearchBar?Icons.search:Icons.refresh),turns:tween),
        child :Icon(_hasSearchBar?Icons.search:Icons.refresh),
        onPressed: _hasSearchBar?clickSearch:_onRefresh,
      ),
    );
  }
fieldClose(){
  _hasSearchBar=false;
  fadeRGBO(Colors.white, Colors.blue, 1.0);
}
Widget waitData(){
  // print(result);
   List ret;
   if(null==result){ret=[{"wendu":"Null","sn":"Not Found Sn","yyyy":"yyyy","mm":"mm","dd":"00:00"}];}else{ret=result;}
  // _onRefresh();
  
  return WdCard(wdData:ret);
}
Future<Null> _onRefresh() async{
  _loadSns();
  await Future.delayed(Duration(microseconds: 500),(){
    setState(() {
        });
  });
}
@override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}