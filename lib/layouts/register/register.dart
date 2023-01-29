import 'package:ai_control/app_localizations.dart';
import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';


import '../../bloc/main_cubit/mian_cubit.dart';
import '../../bloc/register_cubit/cubit.dart';
import '../../bloc/register_cubit/states.dart';
import '../login/login.dart';
import '../main_home/home.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();
  var genderController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final database = FirebaseDatabase.instance.ref();

   String? type ;

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
                            label: Text(
                                "Enter name".tr(context),
                                style: Theme.of(context).textTheme.bodyText1
                            ),
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
                            label: Text(
                                "Enter e-mail".tr(context),
                                style: Theme.of(context).textTheme.bodyText1),
                            prefixIcon: Icon(
                              Icons.mail,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter your age';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            label: Text(
                                "Enter age".tr(context),
                                style: Theme.of(context).textTheme.bodyText1),
                            prefixIcon: Icon(
                              Icons.numbers,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: addressController,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter your address';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            label: Text(
                                "Enter address".tr(context),
                                style: Theme.of(context).textTheme.bodyText1),
                            prefixIcon: Icon(
                              Icons.place,
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
                            label: Text(
                                "Enter Number".tr(context),
                                style: Theme.of(context).textTheme.bodyText1),


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
                              label: Text(
                                  "passowrd".tr(context),
                                  style: Theme.of(context).textTheme.bodyText1),

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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text('Please Select Your Gender :',
                           style: TextStyle(
                             fontSize: 20.sp,
                             fontWeight: FontWeight.bold,
                             color: Colors.lightBlue
                           ),
                        ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: type=='Male' ? HexColor('#2888ff') : Colors.grey,
                                  ),
                                  child: MaterialButton(

                                    onPressed: (){
                                      setState(() {

                                        type ='Male';


                                      });
                                    },
                                    child: Text(
                                      'Male',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color:  Theme.of(context).scaffoldBackgroundColor,
                                      ),
                                    ),

                                  ),
                                ),),
                                SizedBox(width: 6.h,),
                                Expanded(child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:type == 'Female' ? HexColor('#2888ff') :Colors.grey  ,
                                  ),
                                  child: MaterialButton(

                                    onPressed: (){
                                      setState(() {

                                        type = 'Female';


                                      });
                                    },
                                    child: Text(
                                      'Female',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).scaffoldBackgroundColor  ,
                                      ),
                                    ),

                                  ),
                                ),),
                              ],
                            ),

                          ],
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
                       type == null ? Container():  ConditionalBuilder(
                          condition: state != RegisterLoadingStates,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            height: 50.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white24)),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    age: ageController.text,
                                    address: addressController.text,
                                    type: type??'unknown',
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    context: context,


                                  );
                                }
                              },
                              color: HexColor('#2888ff'),
                              textColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              child: Text(
                                  "REGISTER".tr(context),
                                  style: Theme.of(context).textTheme.headline4),

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
                                "have an account?".tr(context),
                                style: Theme.of(context).textTheme.bodyText1),

                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                        (route) => false);
                              },
                              child: Text(
                                  "LOGIN".tr(context),
                                  ),
                            )
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
