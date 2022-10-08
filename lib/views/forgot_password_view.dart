
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/utilities/dialogs/password_reset_email_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState(){
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener:  (context, state) async {
      if(state is AuthStateForgotPassword){
        if(state.hasSentEmail){
        _controller.clear();
        await showPasswordResetSentDialog(context);
        }
       if(state.exception != null){
           // ignore: use_build_context_synchronously
           await showErrorDialog(context,'No podemos procesar su petición , asegurese de ser un usuario registrado o si no registre un usuario en un paso antes');
       }
      }
      
      },
      child :  Scaffold(
         appBar: AppBar(title: const Text('Contraseña Olvidada'),
         ),
         body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
             children: [ const Text('si olvido su contraseña , solo ingrese su email y le enviaremos un link para reestablecer contraseña'
              
             ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: ' Tu correo ...'
                ) ,     
              ),

              TextButton(
                onPressed: 	(){
                final email = _controller.text;
                context.read()<AuthBloc>().add(AuthEventForgotPassword(email: email));
                }, child: const Text('Enviame el link para reestablecer contraseña'),
              ),

                 TextButton(
                onPressed: 	(){
                 context.read<AuthBloc>().add(const AuthEventLogOut(),);   
                }, child: const Text('atras'),
              )
             ],

          ),
         ),
      ),
      );

  }
  }
