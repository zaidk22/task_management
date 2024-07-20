import 'package:dartz/dartz.dart';
import 'package:task_management/domain/entities/users/user_response.dart';

import '../../data /failure/failure.dart';


abstract class IUserRepo {
  Future<Either<Failure,List<User>>> getUsers();
   Future<Either<Failure,User>> getUsersDetails(String id);
}
