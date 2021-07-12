import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

class DriveMod extends StatefulWidget {
  @override
  _DriveModState createState() => _DriveModState();
}

class _DriveModState extends State<DriveMod> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
      appBar: new AppBar(
        title: new Text('Drive Mode'),
      ),
        body: Center(
            child: Container(
                child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(minimum: 0, maximum: 150,
                          ranges: <GaugeRange>[
                            GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
                            GaugeRange(startValue: 50,endValue: 100,color: Colors.orange),
                            GaugeRange(startValue: 100,endValue: 150,color: Colors.red)],
                          pointers: <GaugePointer>[
                            NeedlePointer(value: 0)],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(widget: Container(child:
                            Text('0',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                                angle: 90, positionFactor: 0.5
                            )]
                      )])
            )),
      ));
  }
}
