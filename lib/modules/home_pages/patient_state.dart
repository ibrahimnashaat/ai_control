import 'dart:math';
import 'package:ai_control/modules/real_time_graph/real_time_graph.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:firebase_database/firebase_database.dart';

class Patient extends StatefulWidget {
  const Patient({Key? key}) : super(key: key);

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  final database = FirebaseDatabase.instance.ref();
  bool isLive = false;



  @override
  Widget build(BuildContext context) {
    final dailySpecialRef = database.child('first/');
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: HexColor('#2888ff'),
              ),
              child: Expanded(
                flex:40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 6, top: 10),
                      child: Text(
                        'Good Morning!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24, right: 4, bottom: 10),
                      child: Text(
                        'please connect the ECG device before you click on the start button!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),

            isLive ? Expanded(
                flex: 60,
                child: MyHomePage()):  Image.asset(
              'assets/images/12.gif',
            ),



            SizedBox(
              height: 18,
            ),
            Expanded(
              flex: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    minWidth: 120,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.blue)),
                    onPressed: () {
                      setState((){
                        isLive = true;
                      });
                    },
                    color: HexColor('#2888ff'),
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Text("start", style: TextStyle(fontSize: 28)),
                  ),
                  Text(
                    '|',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                  MaterialButton(
                    minWidth: 120,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.redAccent)),
                    onPressed: () {
                      setState((){
                        isLive = false;
                      });

                    },
                    color: Colors.red,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Text("stop", style: TextStyle(fontSize: 28)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}

