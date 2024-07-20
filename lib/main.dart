import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:task_management/blocs/auth/auth_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_management/blocs/users_bloc/users_bloc.dart';
import 'package:task_management/domain/entities/task/task_request.dart';
import 'blocs/task/task_bloc.dart';
import 'data /local_data/hive_respository.dart';
import 'injection.dart';

import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.prod);

  await initHive();
  runApp( MyApp());
}

initHive() async {
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TaskRequestAdapter());
  HiveTaskStorage.openBox();
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
    final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
  
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<AuthBloc>()..add(CheckAuthState())),

        BlocProvider(create: (context) => getIt<TaskBloc>()..add(LoadTasks())),
        BlocProvider(create: (context) => getIt<UserBloc>()..add(FetchUsers())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(),
        title: 'Task Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
