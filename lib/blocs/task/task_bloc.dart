import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:task_management/domain/entities/task/task_request.dart';
import 'package:task_management/domain/repositories/i_task_repo.dart';

import '../../data /local_data/hive_respository.dart';



part 'task_event.dart';
part 'task_state.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ITaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final eitherTasks = await taskRepository.getTasks();

      await eitherTasks.fold(
        (failure) async {
          emit(TaskError(failure.message));
          final storedTasks = await HiveTaskStorage.getTasks();
          emit(TaskLoaded(storedTasks));
        },
        (tasks) async {
          await HiveTaskStorage.storeTasks(tasks);
          final storedTasks = await HiveTaskStorage.getTasks();
          emit(TaskLoaded(storedTasks));
        },
      );
    } catch (e) {
      emit(TaskError(e.toString()));
      final Logger log = Logger();
      log.e("Exception while getting tasks: $e");
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final eitherTask = await taskRepository.createTasks(event.task);
      eitherTask.fold(
        (failure) => emit(TaskError(failure.message)),
        (_) => add(LoadTasks()),
      );
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final eitherTask = await taskRepository.updateTasks(
          event.task, event.task.id?.toString() ?? "");
      eitherTask.fold(
        (failure) => emit(TaskError(failure.message)),
        (_) => add(LoadTasks()),
      );
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final eitherTask = await taskRepository.deleteTasks(event.id);
      eitherTask.fold(
        (failure) => emit(TaskError(failure.message)),
        (_) {
          emit(const DeleteSuccess(success: "Deleted"));
          add(LoadTasks());
        },
      );
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
