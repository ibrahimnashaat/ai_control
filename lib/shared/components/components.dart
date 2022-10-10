import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double wid = double.infinity,
  double r = 10.0,
  required String text,
  bool isUpper = true,
  Color back = Colors.blue,
  required Function() function,
}) =>
    Container(
      width: wid,
      decoration: BoxDecoration(
        color: back,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

class DefaultFormField extends StatelessWidget {
  TextEditingController controller;
  TextInputType type;
  String label;
  IconData prefix;

  DefaultFormField({
    required this.controller,
    required this.type,
    required this.label,
    required this.prefix,
  });

  @override
  Widget build(BuildContext context)
  {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: label,
        prefixIcon: Icon(
          prefix,
        ),
      ),
    );
  }
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);


Widget buildSeparator() => Container(
  height: 1.0,
  width: double.infinity,
  color: Colors.grey[300],
);

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

