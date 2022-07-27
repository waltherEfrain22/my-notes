
//login exceptions
class UserNotFoundAuthException implements Exception{}

class WrongPasswordAuthException implements Exception{}
//register Exceptions

class WeakPasswordAuthException implements Exception{}
class EmailAreadyInUseAuthException implements Exception{}
class InvalidEmailAuthException implements Exception{}

//generic exceptions
class GenericAuthException implements Exception{}
class UserNotLoggedInAuthException implements Exception{}


