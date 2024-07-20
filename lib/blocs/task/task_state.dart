part of 'task_bloc.dart';


abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskRequest> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}


class DeleteSuccess extends TaskState {
  final String success;
  const DeleteSuccess({required this.success});
    @override
  List<Object> get props => [success];
}

class TaskError extends TaskState {
  final String error;

  const TaskError(this.error);

  @override
  List<Object> get props => [error];
}
