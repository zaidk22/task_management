import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/presentation/screens/user_list.dart';
import 'package:task_management/routes/routes.gr.dart';
import 'package:task_management/utils/helper/secure_storage_helper.dart';

import '../../blocs/task/task_bloc.dart';
import 'task_input_screen.dart';

@RoutePage()
class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          GestureDetector(
              onTap: () => AutoRouter.of(context).push(const UserRoute()),
              child: const Row(
                children: [
                  CircleAvatar(child: Icon(Icons.person_3_outlined)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Users",
                  ),
                ],
              )),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () async {
                await SecureStorage.deleteToken();
                AutoRouter.of(context).pushAndPopUntil(
                  SigninRoute(),
                  predicate: (_) => false,
                );
              },
              child: Text("Logout")),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is DeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Deleted Succesfully")));
          }
        },
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return ListTile(
                    title: Text(task.title ?? ""),
                    subtitle: Column(
                      children: [
                        Text(task.description ?? ""),
                        Text(task.status ?? ""),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        BlocProvider.of<TaskBloc>(context)
                            .add(DeleteTask(task.id?.toString() ?? ""));
                      },
                    ),
                    onTap: () {
                      // Navigate to task edit screen (not implemented in this example)
                    },
                  );
                },
              );
            } else if (state is TaskError) {
              return const Center(child: Text('Failed to load tasks'));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).push(const TaskInputRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
