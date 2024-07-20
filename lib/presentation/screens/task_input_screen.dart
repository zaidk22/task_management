import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/domain/entities/task/task_request.dart';

import '../../blocs/task/task_bloc.dart';
import '../../blocs/users_bloc/users_bloc.dart';


@RoutePage()
class TaskInputScreen extends StatefulWidget {
  const TaskInputScreen({super.key});

  @override
  _TaskInputScreenState createState() => _TaskInputScreenState();
}

class _TaskInputScreenState extends State<TaskInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();
  String _priority = 'Medium';
  String _status = 'To-Do';
  String? _assignedUser; // Initially null

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(FetchUsers()); // Fetch users on init
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  void _submitTask() {
    if (_formKey.currentState!.validate()) {
      final task = TaskRequest(
        id: 12,
        completed: false,
        userId: 10,
        assigned: _assignedUser??"",
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: _dueDateController.text,
        priority: _priority,
        status: _status,
      );
      BlocProvider.of<TaskBloc>(context).add(AddTask(task));
      Navigator.pop(context);
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dueDateController.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dueDateController,
                decoration: InputDecoration(
                  labelText: 'Due Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDueDate(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the due date';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _priority,
                decoration: const InputDecoration(labelText: 'Priority'),
                items: ['High', 'Medium', 'Low'].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value.toString();
                  });
                },
              ),
              DropdownButtonFormField(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['To-Do', 'In Progress', 'Done'].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value.toString();
                  });
                },
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserLoaded) {
                    return DropdownButtonFormField(
                      value: _assignedUser,
                      decoration: const InputDecoration(labelText: 'Assigned User'),
                      items: state.users.map((user) {
                        return DropdownMenuItem(
                          value: user.firstName,
                          child: Text(user.firstName??""),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _assignedUser = value.toString();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a user';
                        }
                        return null;
                      },
                    );
                  } else {
                    return const Text('Failed to load users');
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTask,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
