
import 'package:ai_control/models/class_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



void showToast({required String msg, required ToastStates state})=>Fluttertoast.showToast(
msg: msg,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0);

enum ToastStates{ERORR, SUCCESS, WARNING}

Color chooseToastColor(ToastStates test){
  Color color;
  switch(test){

    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERORR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.orange;
      break;



  }

  return color;
}

//
// UserModel? model;
// void firebaseAuth (){
//   final uId = FirebaseAuth.instance.currentUser?.uid;
//
//   FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
//     model = UserModel.fromJson(value.data()!);
//   });
//
// }

