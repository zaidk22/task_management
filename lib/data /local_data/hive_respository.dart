import 'package:hive/hive.dart';
import 'package:task_management/domain/entities/task/task_request.dart';


class HiveTaskStorage {
  static const String _boxName = 'tasks';
    static HiveTaskStorage? _instance;

  // Private constructor to prevent instantiation from outside
  HiveTaskStorage._();

  // Singleton instance retrieval
  static HiveTaskStorage get instance {
    _instance ??= HiveTaskStorage._();
    return _instance!;
  }

static Future<void> openBox() async {
    await Hive.openBox<TaskRequest>(_boxName);
  }

 static Future<void> storeTasks(List<TaskRequest> tasks) async {
    final box = await Hive.openBox<TaskRequest>(_boxName);
    await box.clear(); 
    await box.addAll(tasks);
  }

static  Future<List<TaskRequest> >getTasks() async {
    final box = await Hive.openBox<TaskRequest>(_boxName);
    return box.values.toList();
  }

static Future<void> deleteAllTasks() async {
    final box = await Hive.openBox<TaskRequest>(_boxName);
    await box.clear();
  }

static  Future<void> deleteTask(String id) async {
    final box = await Hive.openBox<TaskRequest>(_boxName);
    await box.delete(id);
  }

static  Future<void> editTask(String id, TaskRequest updatedTask) async {
    final box = await Hive.openBox<TaskRequest>(_boxName);
    await box.put(id, updatedTask);
  }
}
