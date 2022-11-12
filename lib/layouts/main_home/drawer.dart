import 'package:ai_control/bloc/main_cubit/main_states.dart';
import 'package:ai_control/bloc/main_cubit/mian_cubit.dart';
import 'package:ai_control/bloc/register_cubit/cubit.dart';
import 'package:ai_control/bloc/register_cubit/states.dart';
import 'package:ai_control/models/class_user_model.dart';
import 'package:ai_control/modules/drawer_pages/user_profile.dart';
import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../modules/drawer_pages/about_us.dart';
import '../../modules/drawer_pages/contact_us.dart';
import '../../shared/constatnts/constants.dart';
import '../login/login.dart';

class Drawers extends StatefulWidget {
   Drawers({Key? key}) : super(key: key);

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStutes>(
     listener: (context, state){},
     builder: (context,state){



      final model = SocialCubit.get(context).userModel;

      var image = model?.image;
      var cover = model?.cover;
      return Drawer(




       child: Container(

        child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
          children: [
           Container(
            height: 36.h,
            child: Stack(
             alignment:  AlignmentDirectional.bottomCenter,
             children: [
              Align(
               child: Container(
                height: 30.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(10),
                     topRight: Radius.circular(10),

                    ),
                    color: Colors.black12,
                    image:  DecorationImage(
                        image: NetworkImage(
                            '$cover',

                        ),
                        fit: BoxFit.cover
                    )
                ),

               ),
               alignment: AlignmentDirectional.topCenter,
              ),
              GestureDetector(
               onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                 return UserProfile();
                }));
               },
                child: CircleAvatar(
                 radius:60 ,
                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                 child: CircleAvatar(
                  radius: 56,
                  backgroundColor: Colors.black12,
                  backgroundImage: NetworkImage(
                      '$image',
                  ),
                 ),
                ),
              ),
             ],
            ),
           ),

           SizedBox(
            height: 6.h,
           ),

           Row(
            children: [
             Icon(
              Icons.person,
              color: HexColor('#2888ff'),
             ),
             TextButton(
              onPressed: (){
               Navigator.push(context,MaterialPageRoute(builder: (context){
                return UserProfile();
               }));
              },
              child:  Text(
               'profile',
               style: TextStyle(
                fontSize: 20,
                color: HexColor('#2888ff'),

               ),
              ),

             ),
            ],
           ),
           Row(
            children: [
             Icon(
              Icons.help_outline,
              color: HexColor('#2888ff'),
             ),
             TextButton(
              onPressed: (){
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
               );
              },
              child:  Text(
               'about us',
               style: TextStyle(
                fontSize: 20,
                color: HexColor('#2888ff'),

               ),
              ),

             ),
            ],
           ),
           Row(
            children: [
             Icon(
              Icons.support_agent,
              color: HexColor('#2888ff'),
             ),
             TextButton(
              onPressed: (){
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Contact()),
               );
              },
              child:  Text(
               'contact us',
               style: TextStyle(
                fontSize: 20,
                color: HexColor('#2888ff'),

               ),
              ),

             ),
            ],
           ),

           const Spacer(),
           Row(

            children: [
             Icon(
              Icons.logout,
              color: HexColor('#2888ff'),
             ),
             TextButton(
              onPressed: (){
               cachHelper.removeData('uId').then((value) async {

                 Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(builder: (context)=>Login()), (route) =>false
                 );



               }
               );

               FirebaseAuth.instance.signOut();
              },
              child: Text(
               'logout',
               style: TextStyle(
                fontSize: 20,
                color: HexColor('#2888ff'),

               ),
              ),

             ),
            ],
           ),
          ],
         ),
        ),
       ),
      );
     },
    );
  }
}
