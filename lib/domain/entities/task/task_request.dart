

import 'package:hive/hive.dart';
part 'task_request.g.dart';

 @HiveType(typeId: 0)
class TaskRequest {
 
 @HiveField(0)
  int? userId;
  @HiveField(1)
  int? id;
 @HiveField(2)
  String? description;
  @HiveField(3)
  String? dueDate;
 @HiveField(4)
  String? title;
 @HiveField(5)
  bool? completed;
 @HiveField(6)
  String? priority;
 @HiveField(7)
  String? status;
 @HiveField(8)
  String? assigned;

  TaskRequest({this.userId, this.id, this.description, this.dueDate, this.title, this.completed, this.priority, this.status, this.assigned});

  TaskRequest.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    id = json["id"];
    description = json["description"];
    dueDate = json["dueDate"];
    title = json["title"];
    completed = json["completed"];
    priority = json["priority"];
    status = json["status"];
    assigned = json["assigned"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["userId"] = userId;
    _data["id"] = id;
    _data["description"] = description;
    _data["dueDate"] = dueDate;
    _data["title"] = title;
    _data["completed"] = completed;
    _data["priority"] = priority;
    _data["status"] = status;
    _data["assigned"] = assigned;
    return _data;
  }
}