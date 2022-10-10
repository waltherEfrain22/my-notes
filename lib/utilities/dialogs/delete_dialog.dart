import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';


Future<bool> showDeleteDialog(BuildContext context){
return showGenericDialog<bool>(
  context: context,
 title: 'Eliminar', 
 content: '¿Está seguro de borrar esta nota?',
  optionBuilder: () => {
  'Cancel':false,
  'Yes' : true, 
  }, ).then((value) => value ?? false,
  );
}