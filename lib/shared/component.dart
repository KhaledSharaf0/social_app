import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultButton({
  required double width,
  required Color color,
  double raduis = 0.0,
  required Function()? function,
  required String text,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: color,
      ),
      child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: GoogleFonts.oswald(fontSize: 25.0, color: Colors.black),
          )),
    );

Widget defaultFormField({
  required TextEditingController controller,
  bool observeText = true,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  required String? Function(String?)? validator,
  required String label,
  required IconData preifx,
  IconData? suffix,
  bool isPassword = false,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          preifx,
        ),
        suffixIcon:suffix !=null ? IconButton(onPressed: suffixPressed, icon: Icon(suffix)) : null,
        border: OutlineInputBorder(),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );



