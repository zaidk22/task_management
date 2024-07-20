import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/web.dart';
import 'package:task_management/data%20/failure/failure.dart';
import 'package:task_management/domain/entities/task/delete_task_reponse.dart';
import 'package:task_management/domain/entities/task/get_task_response.dart';
import 'package:task_management/domain/entities/task/task_request.dart';
import 'package:task_management/domain/repositories/i_task_repo.dart';

import '../../service/api_service.dart';
import '../../utils/api_constants/api_constants.dart';

@LazySingleton(as: ITaskRepository)
class TaskRepository extends ITaskRepository {
  TaskRepository();

  @override
  Future<Either<Failure, TaskRequest>> createTasks(
      TaskRequest taskRequest) async {
    try {
      final response = await ApiService(ApiConstants.BASE_URL_1).post(
        'todos', // Replace with your actual endpoint
        data: taskRequest.toJson(),
      );
      
      return Right(TaskRequest.fromJson(response.data));
    } catch (e) {
   
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteTaskResponse>> deleteTasks(String id) async {
    try {
      final response = await ApiService(ApiConstants.BASE_URL_1).delete(
        'todos/$id', // Replace with your actual endpoint
      );
      return Right(DeleteTaskResponse.fromJson(response.data));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskRequest>>> getTasks() async {
    try {
      final response = await ApiService(ApiConstants.BASE_URL_1).get(
        'todos', // Replace with your actual endpoint
      );
      final List<dynamic> data = response.data;
       

      final tasks = data.map((json) => TaskRequest.fromJson(json)).toList();
      return Right(tasks);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskRequest>> updateTasks(
      TaskRequest taskRequest, String id) async {
    try {
      final response = await ApiService(ApiConstants.BASE_URL_1).put(
        'todos/$id', // Replace with your actual endpoint
        data: taskRequest.toJson(),
      );
      return Right(TaskRequest.fromJson(response.data));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
