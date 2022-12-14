import 'package:ai_control/bloc/main_cubit/main_states.dart';
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

              actions: [
                BlocBuilder<SocialCubit,SocialStutes>(
                  builder: (context,state){
                    return IconButton(
                      onPressed: (){
                        SocialCubit.get(context).changeSocialMode(formSared:false);
                      },
                      icon: Icon(Icons.brightness_4_outlined),
                    );
                  },

                ),
                SizedBox(
                  width: 10,),

                BlocConsumer<LocaleCubit, ChangeLocaleState>(
                  listener: (context, state) {

                  },
                  builder: (context, state) {
                    return DropdownButton<String>(
                      value: state.locale.languageCode,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: ['ar', 'en'].map((String items) {
                        return DropdownMenuItem<String>(
                          value: items,
                          child: Text(items,
                          style: TextStyle(color: HexColor('#2888ff') ),),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          context.read<LocaleCubit>().changeLanguage(newValue);
                        }
                      },
                    );
                  },
                ),
              ],
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
