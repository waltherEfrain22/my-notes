import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';


@immutable //they can not have fields that change
class AuthUser{
 final String id;
  final String email;
  final bool isEmailVerified;

  const  AuthUser( {required this.id,
    required this.email,
    required this.isEmailVerified
  });//this is the constructor

  factory AuthUser.fromFirebase(User user)=>
   AuthUser(  
    id:user.uid,
    email:user.email!,
     isEmailVerified:user.emailVerified); 


}