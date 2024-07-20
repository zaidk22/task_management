part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthInitialEvent extends AuthEvent {
  final bool isLoading;
  const AuthInitialEvent({required this.isLoading});
  @override
  List<Object> get props => [];
}

class AuthEmailChanged extends AuthEvent {
  final String email;

  const AuthEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class AuthPasswordChanged extends AuthEvent {
  final String password;

  const AuthPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class AuthSubmitted extends AuthEvent {
  final String email;
  final String password;
  final bool isSignup;

  const AuthSubmitted({
    required this.email,
    required this.password,
    required this.isSignup,
  });

  @override
  List<Object> get props => [email, password, isSignup];
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUpRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class CheckAuthState extends AuthEvent {}