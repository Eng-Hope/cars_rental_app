
import 'package:flutter/material.dart';
class CommonMethods {
  checkConnectivity(BuildContext context) async
  

  

   {
    if(!context.mounted) return;
   displaySnackBar('internet is not available, check your connection and try again ', context);

   }

  void displaySnackBar(String s, BuildContext context) {}
  }

  displaySnackBar(String messageText, BuildContext context)
  {
var snackBar = SnackBar(content:Text( messageText));
ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
  // connectivity() {}

