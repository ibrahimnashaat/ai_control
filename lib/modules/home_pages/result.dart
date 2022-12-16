import 'package:ai_control/app_localizations.dart';
import 'package:ai_control/modules/home_pages/dl_model/classifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/main_cubit/main_states.dart';
import '../../bloc/main_cubit/mian_cubit.dart';

class result extends StatefulWidget {


  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  final picker = ImagePicker();
 Classifier classifier = Classifier();
late PickedFile image;
int digit = -1;



@override
  Widget build(BuildContext context) {
    // return Scaffold(
    //
    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: Colors.black,
    //     child: Icon(Icons.camera_alt_outlined),
    //     onPressed: ()
    //     async {
    //       image = (await picker.getImage(
    //         source: ImageSource.gallery,
    //         maxHeight: 300,
    //         maxWidth: 300,
    //         imageQuality: 100,
    //       ))!;
    //       digit = await classifier.classifyImage(image);
    //       setState(() {});
    //     },
    //   ),
    //   appBar: AppBar(
    //     backgroundColor:Colors.indigo,
    //     title:  Text(
    //         " predict disease☺".tr(context)
    //         , style: Theme.of(context).textTheme.headline4),
    //   ),

    //   body: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: SingleChildScrollView(
    //         child: Column(
    //
    //           children: [
    //
    //             Text(
    //                 "Image will be shown below".tr(context)
    //                 , style: Theme.of(context).textTheme.bodyText1),
    //             SizedBox(
    //               height: 10,
    //             ),
    //               Container(
    //               width: 250,
    //               height:250,
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 border: Border.all(color: Colors.black, width: 2.0),
    //                 // image: DecorationImage(
    //                 //   fit: BoxFit.fill,
    //                 //   image: digit == -1 ?
    //                 //   AssetImage('assets/images/white_background.jpg')
    //                 //        : FileImage(File(image.path)),
    //                 // ),
    //               ),
    //             ),
    //
    //             SizedBox(
    //               height: 30,
    //             ),
    //
    //             Text(
    //               "Current Prediction:".tr(context),
    //               style: Theme.of(context).textTheme.headline4,
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             Text(
    //                 digit == -1 ? "" : "$digit",
    //                 style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  return BlocConsumer<SocialCubit, SocialStutes>(
    listener: (context, state) {},
    builder: (context, state) {


      var model = SocialCubit.get(context).userModel;
      var image = model?.image;
      var cover = model?.cover;

      var profileImage = SocialCubit.get(context).ProfileImage;
      var profileCover = SocialCubit.get(context).CoverImage;





      return Scaffold(
        appBar: AppBar(
          backgroundColor:HexColor('#005b96'),
          title:  Text(
              " predict disease💊".tr(context)
              , style: TextStyle(
            color: Colors.white,
            fontSize: 30,


          )
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right:8 ,left:8 ),
            child: Column(
              children: [
               Text(
                   '||                                                              ||'),
                 Container(
                   padding: EdgeInsets.only(top:10 ,bottom:10 ,right: 10,left: 10),

                     decoration: BoxDecoration(
                         color: HexColor('#005b96'),
                     borderRadius: BorderRadius.only(
                       bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),)),
                   child:
                     Text( "Image will be shown below".tr(context)
                   , style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,

                )
                /* Theme.of(context).textTheme.bodyText1*/),
                 ),
                SizedBox(
                          height: 20,
                        ),
                Container(
                  color: Colors.white,
                  height: 36.h,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,

                          children: [
                            Container(
                              height: 50.h,

                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color: HexColor('#005b96'),
                                image: DecorationImage(
                                  image: profileCover == null ?NetworkImage(
                                    '$cover',
                                  ) : FileImage(profileCover) as ImageProvider,


                                ),
                              ),
                            ),
                            IconButton(

                                onPressed: ()async{
                                  SocialCubit.get(context).getCoverImage();
                                  profileCover = await classifier.classifyImage(this.image);
                                         setState(() {});
                                },
                                icon:CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.lightBlue.withOpacity(0.7),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                )
                            ),
                          ],
                        ),
                        alignment: AlignmentDirectional.bottomEnd,
                      ),
                      // Stack(
                      //   alignment: AlignmentDirectional.bottomEnd,
                      //
                      //   children: [
                      //     CircleAvatar(
                      //       radius: 60,
                      //       backgroundColor:
                      //       Theme.of(context).scaffoldBackgroundColor,
                      //       child: CircleAvatar(
                      //         radius: 56,
                      //         backgroundColor: Colors.black12,
                      //         backgroundImage:profileImage == null ? NetworkImage('$image') : FileImage(profileImage) as ImageProvider,
                      //       ),
                      //     ),
                      //     IconButton(
                      //         onPressed: (){
                      //           SocialCubit.get(context).getProfileImage();
                      //         },
                      //         icon:CircleAvatar(
                      //           radius: 28,
                      //           backgroundColor: Colors.lightBlue.withOpacity(0.7),
                      //           child: Icon(
                      //             Icons.camera_alt_outlined,
                      //             color: Colors.white,
                      //           ),
                      //         )
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Text(
                    "||                                                     ||"
                     ),

                Container(
                  padding: EdgeInsets.only(top:10 ,bottom:10 ,right: 10,left: 10),

                  decoration: BoxDecoration(
                      color: HexColor('#005b96'),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),)),
                  child:
                  Text( "Current Prediction:".tr(context)
                      , style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,

                      )
                    /* Theme.of(context).textTheme.bodyText1*/),
                ),
            SizedBox(
              height: 10,
            ),
            Text(
                profileCover == profileCover ? "$profileCover":"$image" ,
                              style: TextStyle(
                                color: Colors.red,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)
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
