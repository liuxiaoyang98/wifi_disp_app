import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';
import '../widgets/wd_card_plus.dart';
import '../widgets/drawer.dart';

class HomePagePlus extends StatefulWidget {
  _HomePagePlusState createState() => _HomePagePlusState();
}

class _HomePagePlusState extends State<HomePagePlus>  with SingleTickerProviderStateMixin {
  var data;
  var switchColor;
  var result;
  Color fromColor;
  Color toColor;
  List<String> _sns;
  Map <int,List<Map<String, String>>> cardData;
  // ValueNotifierData vd;

  void _snAutoSave(String sn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
          _sns = prefs.getStringList("SNS")??[];
           for(String v in _sns){
             if(v==sn)return;
           }
          _sns.insert(_sns.length, sn);
          // vd.value=_sns;
          prefs.setStringList("SNS", _sns);
        });
  }
  _clear()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("SNS");
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
    // vd = ValueNotifierData(['Hello']);
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
            _snAutoSave(textField.text);
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
      backgroundColor: Colors.grey[300],
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
          _hasSearchBar?
          IconButton(
            onPressed:fieldClose,
            icon:Icon(Icons.close,color: Colors.blueGrey,)
          ):PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz),
          itemBuilder: (BuildContext context)=><PopupMenuItem<String>>[ 
            new PopupMenuItem(
              value:"settings",child:
              FlatButton(
                child: Text("设置",style: TextStyle(fontSize: 22.0,color: Colors.black87),),
                padding: EdgeInsets.all(0),
                onPressed:(){
                Navigator.pop(context);
                Navigator.pushNamed(context, "options");} ,
              )
              ),
            new PopupMenuItem(
              value: "222222",
              child:
              FlatButton(
                child: Text("设置",style: TextStyle(fontSize: 22.0,color: Colors.black87),),
                padding: EdgeInsets.all(0),
                onPressed:(){
                Navigator.pop(context);
                Navigator.pushNamed(context, "options");} ,
              ),
              ),
            new PopupMenuItem(
              value: "33333",
              child:
              FlatButton(
                child: Text("设置",style: TextStyle(fontSize: 22.0,color: Colors.black87),),
                padding: EdgeInsets.all(0),
                onPressed:(){
                Navigator.pop(context);
                Navigator.pushNamed(context, "options");} ,
              )
              ),
          ]
          ),
          
        ],
      ),
      body:
      Center(
        // child:hasResult?loops:WdCard(wdData:result),
        child:WdCardPlus()
      ),
      floatingActionButton: FloatingActionButton(
        // child: RotationTransition(child: Icon(_hasSearchBar?Icons.search:Icons.refresh),turns:tween),
        child : Icon(Icons.search),
        onPressed: clickSearch
      ),
      drawer: Drawers(),
    );
  }
fieldClose(){
  _hasSearchBar=false;
  fadeRGBO(Colors.white, Colors.blue, 1.0);
}
Future<Null> _onRefresh() async{
  await Future.delayed(Duration(microseconds: 500),(){
    setState(() {});
  });
}
@override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}