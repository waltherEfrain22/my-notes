import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
class NewNoteView extends StatefulWidget {
  const NewNoteView({Key? key}) : super(key: key);

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  @override
  Widget build(BuildContext context){
 return Scaffold(
    appBar: AppBar(
      title: const Text('Nueva nota'),
    ),
    body: const Text('Escribe tu nota nueva aqui !'),
  );
  }
 
}