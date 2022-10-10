

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: [
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text("Le hemos enviado un correo de verificación, verifique su correo y siga las instrucciones."),
              ),
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text("Si no ha recibido ningun correo, por favor presione el boton de abajo."),
              ),
            TextButton(onPressed:() {
          context.read<AuthBloc>().add( const AuthEventSendEmailVerification());
            }, child: const Text("Enviar email de verificación"),),
            TextButton(onPressed: () async {
                context.read<AuthBloc>().add( const AuthEventLogOut());
            }, child: const Text('Ya confirme el email de verificación'),),

            
            ],
         
          ),
      ),
    );
  }
}