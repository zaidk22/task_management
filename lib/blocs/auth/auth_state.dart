part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthEmailValidation extends AuthState {
  final bool isValid;

  const AuthEmailValidation(this.isValid);

  @override
  List<Object> get props => [isValid];
}

class AuthPasswordValidation extends AuthState {
  final bool isValid;

  const AuthPasswordValidation(this.isValid);

  @override
  List<Object> get props => [isValid];
}
