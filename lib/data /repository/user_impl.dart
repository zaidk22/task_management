import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:task_management/data%20/failure/failure.dart';
import 'package:task_management/domain/entities/users/user_response.dart';
import 'package:task_management/domain/repositories/i_user_repo.dart';

import '../../service/api_service.dart';
import '../../utils/api_constants/api_constants.dart';

@LazySingleton(as: IUserRepo)
class UserRepository extends IUserRepo {
  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final response = await ApiService(ApiConstants.BASE_URL).get(
        'users', // Replace with your actual endpoint
      );
  final Map<String, dynamic> responseData = response.data;
    final List<dynamic> data = responseData['data'];

    final users = data.map((json) => User.fromJson(json)).toList();
    return Right(users);

    } catch (e) {
      var log = Logger();
      log.d(e);
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUsersDetails(String id) async {
    try {
      final response = await ApiService(ApiConstants.BASE_URL).get(
        'users/$id', // Replace with your actual endpoint
      );

      final tasks = User.fromJson(response.data);
      return Right(tasks);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
