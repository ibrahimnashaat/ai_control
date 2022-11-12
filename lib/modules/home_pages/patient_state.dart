import 'package:ai_control/modules/real_time_graph/real_time_graph.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_database/firebase_database.dart';





class Patient extends StatefulWidget {
  const Patient({Key? key}) : super(key: key);

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  late List<LiveData> chartData;
  final database = FirebaseDatabase.instance.ref();
  bool isLive = false;
  final controller = ScreenshotController();
  int count=0;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                    color: HexColor('#2888ff'),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex:1,
                        child: Container(
                          margin: EdgeInsets.only(left: 6, top: 10),
                          child: Expanded(
                            flex: 1,
                            child: Text(
                              'Good Morning!',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),

              isLive
                  ? Expanded(
                flex: 5,
                  child: Screenshot(controller: controller,
                  child: MyHomePage())
              )
                  : Expanded(
                  flex: 5,
                      child: Image.asset(
                        'assets/images/12.gif',
                      ),
                    ),
              SizedBox(
                height: 3.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,


                children: [
                  MaterialButton(
                    minWidth: 120,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.blue)),
                    onPressed: (){
                      setState(() {
                        isLive = true;
                      });

                       // it takes screen shot of graphe widget and store it in firebase storage.

                      controller.capture(delay: const Duration(seconds: 12)).then((capturedImage) async {
                          await FirebaseStorage.instance.ref('order').child('orders$count.jpg').putData(capturedImage!);

                      }).catchError((error){
                        if (kDebugMode) {
                          print(error.toString());
                        }
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
                      setState(() {
                        isLive = false;
                      });
                    },
                    color: Colors.red,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Text("stop", style: TextStyle(fontSize: 28)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
