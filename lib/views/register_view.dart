import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';


import '../utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering){
          if ( state.exception is WeakPasswordAuthException){
            await showErrorDialog(context, 'contraseña Debil');
          } else if (state.exception is EmailAreadyInUseAuthException){
            await showErrorDialog(context, 'El email ya está en uso !');
          } else if (state.exception is GenericAuthException){
            await showErrorDialog(context, 'Fallo al registrar ;(');
          }else if (state.exception is InvalidEmailAuthException){
            await showErrorDialog(context, 'email no valido ;(');
          }
        }
      },

      child: Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Ingresa Tu Correo",
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "Ingresa Tu Contraseña",
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
             

             context.read<AuthBloc>().add(AuthEventRegister(
              email, password));
            },
            child: const Text('Register'),
          ),
          TextButton(
              onPressed: () {
               context.read<AuthBloc>().add(const AuthEventLogOut(),);
              },
              child: const Text('Already Registeres? Login Here'))
        ],
      ),
    ),
      
      
      );
  }
}
