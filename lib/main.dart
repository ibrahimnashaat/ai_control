import 'package:ai_control/shared/constatnts/constants.dart';
import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'bloc/main_cubit/mian_cubit.dart';
import 'layouts/login/login.dart';
import 'layouts/main_home/home.dart';
import 'layouts/on_boarding/on_boarding.dart';
import 'package:sizer/sizer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await cachHelper.init();

  Widget widget ;

   var onBoarding = cachHelper.getData(key: 'onBoarding');
   //var token = cachHelper.getData(key: 'token');
  // print(onBoarding);


   uId = cachHelper.getData(key: 'uId');

  if (uId != null){
    widget = Home();
  }else{
    if(onBoarding != null){
    widget = Login();}
    else{
      widget = OnBoarding();
    }
  }
  // if (onBoarding != null){
  //
  //   if (token != null){
  //     widget = Home();
  //   }else{
  //     widget = Login();
  //   }
  //
  // }else{
  //   widget = OnBoarding();
  // }

  runApp( MyApp(
      startWidget: widget
  ));
}

class MyApp extends StatelessWidget {

  late final bool onBoarding;
  final Widget startWidget;

  MyApp({required this.startWidget});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData(),
        ),

      ],
      child: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                bottomNavigationBarTheme: BottomNavigationBarThemeData(

                  selectedItemColor: HexColor('#2888ff'),

                ),
                appBarTheme: AppBarTheme(

                  iconTheme: IconThemeData(
                      color: HexColor('#2888ff'),
                      size: 30
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0.0,

                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Theme.of(context).scaffoldBackgroundColor,
                    statusBarIconBrightness: Brightness.dark,

                  ),



                ),

                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.grey[120],

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: HexColor('#2888ff'),),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:HexColor('#2888ff'),),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: HexColor('#2888ff')),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                primarySwatch: Colors.blue,
              ),
              home: startWidget,
            );
          }
      ),
    );
  }
}

