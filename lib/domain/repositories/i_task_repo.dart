import 'package:dartz/dartz.dart';
import 'package:task_management/domain/entities/task/delete_task_reponse.dart';
import 'package:task_management/domain/entities/task/get_task_response.dart';
import 'package:task_management/domain/entities/task/task_request.dart';

import '../../data /failure/failure.dart';

abstract class ITaskRepository {
  Future<Either<Failure, List<TaskRequest>>> getTasks();

    Future<Either<Failure, TaskRequest>> createTasks(TaskRequest taskRequest);
    Future<Either<Failure, TaskRequest>> updateTasks(TaskRequest taskRequest, String id);

     Future<Either<Failure, DeleteTaskResponse>> deleteTasks(String id);
}
