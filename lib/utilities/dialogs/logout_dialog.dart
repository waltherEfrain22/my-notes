import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';


Future<bool> showLogOutDialog(BuildContext context){
return showGenericDialog<bool>(
  context: context,
 title: 'Log Out', 
 content: 'Are You Sure You Want To Log Out?',
  optionBuilder: () => {
  'Cancel':false,
  'Log Out' : true, 
  }, ).then((value) => value ?? false,
  );
}