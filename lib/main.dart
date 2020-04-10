import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:mapboxapp/test.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _origin =
      Location(name: "Dharan", latitude:26.8065,  longitude: 87.2846);
  final _destination = Location(
      name: "Ithari", latitude:26.6646,  longitude: 87.2718);

  MapboxNavigation _directions;
  bool _arrived = false;
  double _distanceRemaining, _durationRemaining;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    
    if (!mounted) return;

    _directions = MapboxNavigation(onRouteProgress: (arrived) async {
      _distanceRemaining = await _directions.distanceRemaining;
      _durationRemaining = await _directions.durationRemaining;

      setState(() {
        _arrived = arrived;
        
      });
      if (arrived)
        {
          await Future.delayed(Duration(seconds: 3));
          await _directions.finishNavigation();
           _distanceRemaining = await _directions.distanceRemaining;
      _durationRemaining = await _directions.durationRemaining;
        }
    });

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions.platformVersion;
       _distanceRemaining = await _directions.distanceRemaining;
      _durationRemaining = await _directions.durationRemaining;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
      _distanceRemaining=_distanceRemaining;
        _durationRemaining=_durationRemaining;
    });
  }

  @override
    Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text('Running on: $_platformVersion\n'),
            SizedBox(
              height: 60,
            ),
            RaisedButton(
              child: Text("Start Navigation"),
              onPressed: () async {
                
                await _directions.startNavigation(
                   
                    origin: _origin,

                    destination: _destination,
                    mode: NavigationMode.drivingWithTraffic,
                    simulateRoute: true, 
                   // language: "English", 
                    units: VoiceUnits.metric,
                    );
              },
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Distance Remaining: "),
                      Text(_distanceRemaining != null
                          ? "${(_distanceRemaining ).toStringAsFixed(0)}"
                          : "---")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Duration Remaining: "),
                      Text(_durationRemaining != null
                          ? "${(_durationRemaining / 60).toStringAsFixed(0)} minutes"
                          : "---"),
                          RaisedButton(
                            onPressed:(){
                              
                            }),
                    ],
                  )
                ],
              ),
            ),

          ]),
        ),
      ),
    );
  }
}