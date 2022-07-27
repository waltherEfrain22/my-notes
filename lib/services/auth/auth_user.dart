import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';


@immutable //they can not have fields that change
class AuthUser{
  final bool isEmailVerified;

  const  AuthUser(this.isEmailVerified);//this is the constructor

  factory AuthUser.fromFirebase(User user)=> AuthUser(user.emailVerified); 
}