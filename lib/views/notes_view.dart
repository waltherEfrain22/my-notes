

import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async{
             switch (value) {
               case MenuAction.logout:
                 final shouldlogout =await showLogOutDialog(context);
                 if(shouldlogout){
                    await AuthService.firebase().logOut(); 
                    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute
                    , (_) => false);
                 }
                 break;

               default:
             }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                    value: MenuAction.logout, child: Text('Log Out')),
              ];
            },
          )
        ],
      ),
      body: const Text('Hello my lovely world'),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out '),
        content: const Text('Estas seguro de salirte?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log out')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
