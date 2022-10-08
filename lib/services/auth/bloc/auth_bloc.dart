import 'package:bloc/bloc.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState>{
AuthBloc(AuthProvider provider) : super( const AuthStateUnitialized(isLoading: true)){

 on<AuthEventShouldRegister>((event, emit) {
   
   emit(const AuthStateRegistering(
    exception: null, 
    isLoading: false,
    )
    );

});

on<AuthEventForgotPassword>((event, emit) async{
emit( const AuthStateForgotPassword(
  exception: null, 
  hasSentEmail: false, 
  isLoading: false));

  final email = event.email;
  if(email == null){
    return; // user just wants to go forgot-screen
  }


//el usuario quiere resetear su contraseña
  emit( const AuthStateForgotPassword(
  exception: null, 
  hasSentEmail: false, 
  isLoading: true));


  bool didSendEmail;
  Exception? exception;
  try {
    await provider.sendPasswordReset(toEmail: email);
    didSendEmail = true;
    exception = null;
  } on Exception catch (e) {
    didSendEmail = false;
    exception= e;
  }

  emit( AuthStateForgotPassword(
  exception: exception, 
  hasSentEmail: didSendEmail, 
  isLoading: false));

  
});
// send email
  on<AuthEventSendEmailVerification>((event, emit) async {
    await provider.sendEmailVerification();
    emit(state);
  });

  on<AuthEventRegister>((event, emit) async{
     final email = event.email;
     final password = event.password;

     try {
         await provider.createUser(
          email: email, 
         password: password,);

         await provider.sendEmailVerification();
         emit(const AuthStateNeedVerification(isLoading: false));

     } on Exception catch (e){
      emit(AuthStateRegistering(exception: e, isLoading: false));
     }
  });
  //initialize
   on<AuthEventInitialize>((event, emit) async {
   await provider.initialize();
   final user = provider.currentUser;
  
   if (user == null) {
     emit(const AuthStateLoggedOut(
      exception: null, 
     isLoading: false));
   } else if (user.isEmailVerified == false) {
      emit(const AuthStateNeedVerification(isLoading: false));
   } else {
    emit ( AuthStateLoggedIn(user: user, isLoading: false));
   }

   });  //emit comunication channel to yhe outside world
  // log in

  on<AuthEventLogIn>((event, emit) async {
  
   emit(const AuthStateLoggedOut(
    exception: null, 
    isLoading: true,
    loadingText: 'Por favor Espere Un Momento Mientras Ingresa 🐼'),);
   final email = event.email;
   final password = event.password;

   try {
     final user = await provider.logIn(
      email: email, 
      password: password);

      if(!user.isEmailVerified){
        emit( const AuthStateLoggedOut(
          exception: null, 
         isLoading: false)
        
        );

        emit(const AuthStateNeedVerification(isLoading: false));
      } else {
        emit( const AuthStateLoggedOut(
          exception: null, 
        isLoading: false)
        
        );
           emit(AuthStateLoggedIn(user: user , isLoading: false));
      }
   
   } on Exception catch (_) {
     emit( AuthStateLoggedOut(exception: _, isLoading: false));
   }
  });
  
  //log out
  on<AuthEventLogOut>((event, emit) async{
    try {
      await  provider.logOut();
       emit( const AuthStateLoggedOut(exception: null, isLoading: false));
      
    } on Exception catch (e) {
      emit(AuthStateLoggedOut(exception: e, isLoading: false));
      
    }
  });


  }
}