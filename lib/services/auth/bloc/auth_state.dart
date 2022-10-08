
import 'package:flutter/foundation.dart' show immutable;
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthState{
  final bool isLoading;
  final String? loadingText;
  const AuthState({required this.isLoading , this.loadingText = 'Por Favor Espere Un Momento 🥺' });
}

class AuthStateUnitialized extends  AuthState{
  const AuthStateUnitialized({required bool isLoading }) : super(isLoading: isLoading);
}

class AuthStateRegistering extends AuthState{
    final Exception? exception;

  const AuthStateRegistering({required this.exception, required isLoading })  : super(isLoading: isLoading);
}

class AuthStateForgotPassword extends AuthState{
final Exception? exception;
final bool hasSentEmail;

 const AuthStateForgotPassword({
  required this.exception, 
 required this.hasSentEmail,
 required bool isLoading
 }):super(isLoading:isLoading );
}
class AuthStateLoggedIn extends  AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user,
   required bool isLoading }) :   super(isLoading: isLoading);

}



class AuthStateNeedVerification extends AuthState{
  const AuthStateNeedVerification({required bool isLoading}) :   super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin{
  final Exception? exception; 

  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText
    })  : super(isLoading: isLoading , loadingText: loadingText);


    
      @override

      List<Object?> get props => [exception, isLoading];
}


