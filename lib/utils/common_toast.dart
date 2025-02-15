import 'package:flutter/material.dart';

commonToast(BuildContext context,String message,{Color? bgcolor}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.fixed,
    duration: const Duration(seconds: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    content: Text(message),backgroundColor:  bgcolor?? const Color.fromARGB(255, 254, 78, 65),));
}