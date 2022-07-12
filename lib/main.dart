
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/login_view.dart';

import 'firebase_options.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
        
         
            case ConnectionState.done:
           final user = FirebaseAuth.instance.currentUser;
//Its says if value on the right exists take it, otherwise take false
           if(user?.emailVerified ?? false){
            print("You are a verified user");
           }else{
            print(">You need to verify you email");
           }

           if( user?.isAnonymous ?? false){
              print("Usted ya lo conocemos");      
           }else{
            print("Usted no lo conocemos");
           }

           if(user?.email == false){
                print("su email lo conocemos")  ;     
           }else{
            print("no sabemos su correo");
           }
           return const Text('Done');
         default:
             return const Text('Loading...');
          }
          
        },
      ),
    );
  }


}

