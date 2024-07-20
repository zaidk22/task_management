import 'package:dartz/dartz.dart';
import 'package:task_management/domain/entities/auth/signup_model.dart';
import 'package:task_management/domain/entities/auth/signup_response.dart';

import '../../data /failure/failure.dart';


abstract class IAuthRepository {
  Future<Either<Failure, RegisterResponse>> registerUser(
      RegisterRequest registerRequest);

  Future<Either<Failure, RegisterResponse>> loginUser(
      RegisterRequest registerRequest);
}
