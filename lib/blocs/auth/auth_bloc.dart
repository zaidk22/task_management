// auth_bloc.dart

import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:task_management/domain/entities/auth/signup_response.dart';
import 'package:task_management/utils/helper/secure_storage_helper.dart';

import '../../domain/entities/auth/signup_model.dart';
import '../../domain/repositories/i_auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthSubmitted>(_onSubmitted);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthSignInRequested>(_onSignInRequested);
    on<CheckAuthState>(_onCheckAuthState);
  }

  void _onEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    final isValid = EmailValidator.validate(event.email);
    emit(AuthEmailValidation(isValid));
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    final isValid = event.password.length >= 6;
    emit(AuthPasswordValidation(isValid));
  }

  Future<void> _onSubmitted(
      AuthSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = event.isSignup
        ? await authRepository.registerUser(RegisterRequest(
            email: event.email,
            password: event.password,
          ))
        : await authRepository.loginUser(RegisterRequest(
            email: event.email,
            password: event.password,
          ));

    response.fold(
      (failure) => emit(AuthError(failure.message)),
      (success) {
        SecureStorage.saveToken(success.token ?? "");
        emit(AuthLoaded());
      },
    );
  }

  Future<void> _onSignUpRequested(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await authRepository.registerUser(RegisterRequest(
      email: event.email,
      password: event.password,
    ));

    response.fold(
      (failure) => emit(AuthError(failure.message)),
        (success) {
        SecureStorage.saveToken(success.token);
        emit(AuthLoaded());
      },
    );
  }

  Future<void> _onSignInRequested(
      AuthSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await authRepository.loginUser(RegisterRequest(
      email: event.email,
      password: event.password,
    ));

    response.fold(
      (failure) => emit(AuthError(failure.message)),
      (success) {
        SecureStorage.saveToken(success.token);
        emit(AuthLoaded());
      },
    );
  }

  // Handle CheckAuthState event to check authentication state
  void _onCheckAuthState(CheckAuthState event, Emitter<AuthState> emit) async {
    final token = await SecureStorage.getToken();
    var log = Logger();
    log.d(token);
    if (token != null && token.trim().isNotEmpty) {
      emit(AuthLoaded());
    } else {
      // Token is empty or null, consider user as not authenticated
      emit(AuthInitial());
    }
  }
}
