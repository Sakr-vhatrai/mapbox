import 'package:flutter/material.dart';
import 'package:mapboxapp/main.dart';
class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("data"),
      ),
      body: Column(
        children: <Widget>[
          Text("data"),
          RaisedButton(onPressed: 
          (){
            Test();
          })
        ],
      ),
      
    );
  }
}