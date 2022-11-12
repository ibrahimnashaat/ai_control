
import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';



import '../../bloc/main_cubit/mian_cubit.dart';
import '../../bloc/register_cubit/cubit.dart';
import '../../bloc/register_cubit/states.dart';

import '../../models/class_user_model.dart';
import '../../shared/constatnts/constants.dart';
import '../login/login.dart';
import '../main_home/home.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();
  var genderController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final database = FirebaseDatabase.instance.ref();

  // late String birthDateInString;
  //
  // late DateTime birthDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (BuildContext context, Object? state) {
            if (state is RegisterCreateUserSuccessStates) {
              cachHelper.saveData(key: 'uId', value: state.uId);

              Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => Home()), (route) => false);

              SocialCubit.get(context).getUserData();




            }
          },
          builder: (BuildContext context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),

              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: HexColor('#2888ff'),
                          backgroundImage: AssetImage(
                            'assets/images/3s.png',
                          ),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            label: Text('Enter name'),
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter your e-mail';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            label: Text('Enter e-mail'),
                            prefixIcon: Icon(
                              Icons.mail,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter a phone number';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            label: Text('Enter Number'),
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: RegisterCubit.get(context).isNotVisible,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter a valid password';
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Text('passowrd'),
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(RegisterCubit.get(context).suffix),
                                onPressed: () {
                                  RegisterCubit.get(context)
                                      .changePasswordVisability();
                                },
                              )),
                        ),
                        SizedBox(
                          height: 16,
                        ),




                        // GestureDetector(
                        //     child: new Icon(Icons.calendar_today),
                        //     onTap: ()async{
                        //       final datePick= await showDatePicker(
                        //           context: context,
                        //           initialDate: new DateTime.now(),
                        //           firstDate: new DateTime(1900),
                        //           lastDate: new DateTime(2100)
                        //       );
                        //       if(datePick!=null && datePick!=birthDate){
                        //         setState(() {
                        //           birthDate=datePick;
                        //
                        //
                        //           // put it here
                        //           birthDateInString = "${birthDate.month}/${birthDate.day}/${birthDate.year}"; // 08/14/2019
                        //
                        //         });
                        //       }
                        //     }
                        // ),

                        SizedBox(
                          height: 26,
                        ),
                        ConditionalBuilder(
                          condition: state != RegisterLoadingStates,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            height: 50.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white24)),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );







                                }
                              },
                              color: HexColor('#2888ff'),
                              textColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Text("REGISTER",
                                  style: TextStyle(fontSize: 22)),
                            ),
                          ),
                          fallback: (BuildContext context) =>
                              CircularProgressIndicator(),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'have an account?',
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                      (route) => false);
                                },
                                child: Text('LOGIN'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

  }
}
