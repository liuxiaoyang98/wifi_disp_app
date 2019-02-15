import 'package:flutter/material.dart';

class WdCard extends StatelessWidget {
    WdCard({Key key, this.wdData}):super(key:key);
    List wdData;
    @override
  Widget build(BuildContext context) {
    // print(wdData);
      return ListView.builder(
      itemCount: wdData.length,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (BuildContext context,int index){
        return Container(
                height: 300.0,
                margin: EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: 
                Column(
                  children:<Widget>[
                    Container(
                      alignment: FractionalOffset.topLeft,
                      height:150.0,
                      width:300.0,
                      child:
                      Row(
                        children:<Widget>[
                          Container(
                            alignment: FractionalOffset.topLeft,
                            child:
                            Text(
                              wdData[index]["wendu"],
                                style:TextStyle(
                                  color: Color.fromRGBO(255, 200, 200, 0.9),
                                  fontSize:85.0,
                                  fontWeight: FontWeight.bold,
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
                                color: Colors.white,
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
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 15.0),
                      alignment: FractionalOffset.topLeft,
                      child:
                      Text(
                        "text",
                      style: TextStyle(color:Colors.white),
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0 , 0.0, 0.0, 0.0),
                      alignment: FractionalOffset.topLeft,
                          child:
                          Text(
                            "最后测量时间:  ",
                      style: TextStyle(color:Color.fromRGBO(255, 255, 255, 0.7),fontSize:18.0),
                          ),
                        ),
                        Container(
                          alignment: FractionalOffset.bottomRight,
                          margin: EdgeInsets.fromLTRB(0.0, 50.0, 10.0, 0.0),
                          child:
                            Text(
                              "查看详情>(无效)",
                      style: TextStyle(color:Colors.white70),
                            ),
                        ),
                      ],
                    ),
                  );
      },
    );   
  }
}