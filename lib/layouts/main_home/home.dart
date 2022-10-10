import 'package:ai_control/bloc/register_cubit/cubit.dart';
import 'package:ai_control/layouts/main_home/drawer.dart';
import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/main_cubit/main_states.dart';
import '../../bloc/main_cubit/mian_cubit.dart';
import '../../bloc/main_home_cubit/cubit.dart';
import '../../bloc/main_home_cubit/states.dart';
import '../../modules/drawer_pages/about_us.dart';
import '../../modules/drawer_pages/contact_us.dart';
import '../../modules/home_pages/download.dart';
import '../login/login.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NeuroCubit(),
      child: BlocConsumer<NeuroCubit,NeuroStates>(
       listener: (context , state){},
        builder:  (context, state){

          var cubit = NeuroCubit.get(context);



         return Scaffold(

            appBar: AppBar(


            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomNavItems,
              elevation: 10,

            ),
           drawer: Drawers(),


          );
        },
      ),
    );
  }
}
