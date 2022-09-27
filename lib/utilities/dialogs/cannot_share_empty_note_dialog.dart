import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future <void> showCannotShareEmptyNoteDialog(BuildContext context){


return showGenericDialog(
  context:context , title: 'Compartir',
   content: 'No puedes compartir notas vacias 😿', 
   optionBuilder: () => {
    'OK': null,
   });
}