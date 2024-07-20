import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_management/domain/entities/auth/signup_model.dart';
import 'package:task_management/domain/entities/auth/signup_response.dart';
import 'package:task_management/utils/api_constants/api_constants.dart';
import 'package:task_management/utils/helper/secure_storage_helper.dart';

import '../../domain/repositories/i_auth_repo.dart';
import '../../service/api_service.dart';
import '../failure/failure.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository extends IAuthRepository {
  AuthRepository();

  @override
  Future<Either<Failure, RegisterResponse>> registerUser(
      RegisterRequest registerRequest) async {
    try {
      final response = await ApiService(ApiConstants.BASE_URL).post(
        ApiConstants.REGISTER,
        data: registerRequest.toJson(),
      );
     
      return Right(RegisterResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> loginUser(
      RegisterRequest registerRequest) async {
    try {
      final response = await ApiService(ApiConstants.BASE_URL).post(
        ApiConstants.Login,
        data: registerRequest.toJson(),
      );
      return Right(RegisterResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
