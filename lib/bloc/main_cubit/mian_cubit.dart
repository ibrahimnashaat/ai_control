import 'dart:io';

import 'package:ai_control/models/class_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/constatnts/constants.dart';
import 'main_states.dart';

import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;




class SocialCubit extends Cubit<SocialStutes> {
  SocialCubit() : super(SocialInitiallStates());
  static SocialCubit get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;




  UserModel? userModel;


  void getUserData(

      )
 {
    emit(SocialGetUserLoadingStates());

    // FirebaseFirestore.instance.collection("users").doc(uId).set(model.toMap(),).then((value)
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel=UserModel.fromJson(value.data()!);
      print(userModel!.uId);

      emit(SocialGetUserSuccessStates());
    }).catchError((e){
      emit(SocialGetUserErrorStates(e.toString()));
    });
  }



  File? ProfileImage;
  var picker =ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      ProfileImage = File(pickedFile.path);
      emit( SocialProfileImagePeckerSuccessStates ());
    } else {
      print('No Image Selected!');
      emit(SocialProfileImagePeckerErrorStates());
    }
  }




  File? CoverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      CoverImage = File(pickedFile.path);
      emit( SocialProfileCoverPeckerSuccessStates ());
    } else {
      print('No Image Selected!');
      emit(SocialProfileCoverPeckerErrorStates());
    }
  }



  void upLoudProfilImage({
    required String name,
    required String phone,
    required String email,
    required String bio,
  })
  {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance.ref().child("users/${Uri.file(ProfileImage!.path).
    pathSegments.last}").putFile(ProfileImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          bio: bio,
          name: name,
          phone: phone,
          email: email,
          image: value,
        );

        //emit(SocialUpLoudProfileImageSuccessStates());
      }).catchError((e)
      {
        emit(SocialUpLoudProfileImageErrorStates());
      });
    }).catchError((e){

      emit(SocialUpLoudProfileImageErrorStates());
    });
  }



  void upLoudProfilCover({
    required String name,
    required String phone,
    required String email,
    required String bio,

  })
  {
    emit( SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance.ref().
    child("users/${Uri.file(CoverImage!.path).
    pathSegments.last}").putFile(CoverImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          bio: bio,
          name: name,
          phone: phone,
          email: email,
          cover: value,
        );

        //emit(SocialUpLoudProfileCoverSuccessStates());
      }).catchError((e)
      {
        emit(SocialUpLoudProfileCoverErrorStates());
      });
    }).catchError((e){
      emit(SocialUpLoudProfileCoverErrorStates());
    });
  }

/*  void UpdateUserImages({
  required String name,
    required String phone,
    required String email,
    required String bio,
})

  {
    emit(SocialLodingUserUpdateErrorStates());
    if(CoverImage !=null){
      upLoudProfilCover();
    }else if (ProfileImage !=null)
    {
      upLoudProfilImage();
    } else if (CoverImage !=null&&ProfileImage !=null)
    {

    }
    else
    {
      UpdateUser(
        email: email,
        phone: phone,
        name: name,
        bio: bio,
      );
    }

  }*/


  void updateUser(
      { required String name,
        required String phone,
        required String email,
        required String bio,
        String? image,
        String? cover,})
  {
    UserModel model = UserModel(
      phone: phone,
      name: name,
      bio: bio,
      email: email,
      cover: cover ?? userModel?.cover,
      image: image?? userModel?.image,
      uId: userModel?.uId,
      isEmailVerified: false,

    );
    FirebaseFirestore.instance.collection("users").doc(userModel!.uId).update(model.toMap())
        .then((value)
    {
      getUserData();

    }).catchError((e)
    {
      emit(SocialUserUpdateErrorStates());
    });
  }


}