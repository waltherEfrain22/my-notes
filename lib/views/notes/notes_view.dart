

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/crud/notes_service.dart';
import 'package:mynotes/views/notes/create_update_note_view.dart';
import 'package:mynotes/views/notes/notes_list_view.dart';

import '../../utilities/dialogs/logout_dialog.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

 @override
  void initState()  {
    _notesService = NotesService();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus Notas 😺'),
        actions: [
          IconButton(
            onPressed: (){Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
            },
            icon: const Icon(Icons.add),
          ),
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
      body: FutureBuilder(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder: (context, snapshot){
         switch (snapshot.connectionState) {
           case ConnectionState.done:
            return StreamBuilder(stream: _notesService.allNotes,
            builder: (context, snapshot){
              switch(snapshot.connectionState){                           
                case ConnectionState.waiting:
                case ConnectionState.active:
                 if(snapshot.hasData){
                    final allNotes = snapshot.data as List<DatabaseNote>;
                   return NotesListView(notes: allNotes,
                    onDeleteNote: (note) async{
                      await _notesService.deleteNote(id: note.id);
                    },
                    onTap: (note)  {
                     Navigator.of(context).pushNamed(
                      createOrUpdateNoteRoute
                     ,
                     arguments: note,);
                    },);
                 }else{
                  return const CircularProgressIndicator();
                 }
                default:
                  return const CircularProgressIndicator(); 
              }
            },
            );
            default:
            return const CircularProgressIndicator();
         }
        },
      ),
    );
  }
}
