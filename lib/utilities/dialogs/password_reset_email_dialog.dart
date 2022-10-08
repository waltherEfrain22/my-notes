import 'package:flutter/cupertino.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context){
  return showGenericDialog<void>
  (context: context, 
  title: 'Restablecer Contraseña',
   content: 'Le hemos enviado un link para reestablecer contraseña, por favor revise su email para más imformación',
    optionBuilder: () =>{
      'ok':null,
    },);
}