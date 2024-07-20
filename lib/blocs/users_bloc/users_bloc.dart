import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:task_management/domain/repositories/i_user_repo.dart';
import '../../domain/entities/users/user_response.dart';
// Assuming you have a Failure class to handle errors

part 'users_event.dart';
part 'users_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepo userRepository;

  UserBloc(this.userRepository) : super(UserLoading()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    
  try {
    final result = await userRepository.getUsers();
    result.fold(
      (failure) => emit(UserError('Failed to fetch users: ${failure.message}')), // Handle the failure case
      (users) => emit(UserLoaded(users)), // Handle the success case
    );
  } catch (e) {
    emit(UserError('An unexpected error occurred: $e'));
  }
  }
}
