import 'dart:math';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initiliazed to begin with', () {
      expect(provider.isInitialized, false);
    });

    test('Cant log out if not initialized', () {
      expect(
        provider.logOut(),
        //matcher is expect a function to throw an exception
        throwsA(const TypeMatcher<NotInitiliazedException>()),
      );
    });

    test('should be able to be initiliazed', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test('User should be null after initilization', () {
      expect(provider.currentUser, null);
    });

    test('Should be able to initilize in less than 2 seconds', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    },
        timeout: const Timeout(
          Duration(seconds: 2),
        ));

    test('create user should delegate to LogIn Exceptions', () async {
      final badEmailUser = provider.createUser(
        email: 'foo@bar.com',
        password: 'anypassword',
      );
      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));

      final badPasswordUser = provider.createUser(
        email: 'someone@bar.com',
        password: 'foobar',
      );
          expect(badPasswordUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));
        
        final user = await provider.createUser(
          email:'foo',
          password: 'bar',
        );

        expect(provider.currentUser, user);
        expect(user, isNotNull);
        expect(user.isEmailVerified, false);
    });

    test('logged in user shloud be able to get verified',(){
    provider.sendEmailVerification();

    final user= provider.currentUser;
    expect(user, isNotNull);
    });

    test('Should be Able to log out log in again',() async{
     await provider.logOut();
     await provider.logIn(email: 'email', password:'password', );
     final user = provider.currentUser;
     expect(user,isNotNull);
    
    });
  });
}

class NotInitiliazedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitiliazedException();

    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitiliazedException();
    if (email == 'foo@bar.com') throw UserNotFoundAuthException();
    if (password == 'foobar') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false, email: 'foo@baz.com');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitiliazedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitiliazedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();

    const newUser = AuthUser(isEmailVerified: true, email: 'foo@bar.com');
    _user = newUser;
  }
}
