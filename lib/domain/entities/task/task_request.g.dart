// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskRequestAdapter extends TypeAdapter<TaskRequest> {
  @override
  final int typeId = 0;

  @override
  TaskRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskRequest(
      userId: fields[0] as int?,
      id: fields[1] as int?,
      description: fields[2] as String?,
      dueDate: fields[3] as String?,
      title: fields[4] as String?,
      completed: fields[5] as bool?,
      priority: fields[6] as String?,
      status: fields[7] as String?,
      assigned: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskRequest obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.dueDate)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.completed)
      ..writeByte(6)
      ..write(obj.priority)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.assigned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
