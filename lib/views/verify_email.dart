
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Verification'),),
      body: Column(
          children: [
            const Text("we've sent you an email verification, please open it to verify your account"),
            const Text("If you haven't received a verification email yet, prees the butto below"),
          TextButton(onPressed:() {
           final user = FirebaseAuth.instance.currentUser;
           user?.sendEmailVerification();
    
          }, child: const Text("Send Email Verification"),),
          TextButton(onPressed: () async {
            await FirebaseAuth.instance.signOut();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute, (route) => false);
          }, child: const Text('Restart'),),

          
          ],
       
        ),
    );
  }
}