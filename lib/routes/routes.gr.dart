// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:task_management/presentation/screens/sign_in.dart' as _i1;
import 'package:task_management/presentation/screens/sign_up.dart' as _i2;
import 'package:task_management/presentation/screens/task_input_screen.dart'
    as _i3;
import 'package:task_management/presentation/screens/task_list.dart' as _i4;
import 'package:task_management/presentation/screens/user_list.dart' as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SigninRoute.name: (routeData) {
      final args = routeData.argsAs<SigninRouteArgs>(
          orElse: () => const SigninRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.SigninScreen(key: args.key),
      );
    },
    SignupRoute.name: (routeData) {
      final args = routeData.argsAs<SignupRouteArgs>(
          orElse: () => const SignupRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.SignupScreen(key: args.key),
      );
    },
    TaskInputRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.TaskInputScreen(),
      );
    },
    TaskListRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.TaskListScreen(),
      );
    },
    UserRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.UserScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.SigninScreen]
class SigninRoute extends _i6.PageRouteInfo<SigninRouteArgs> {
  SigninRoute({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          SigninRoute.name,
          args: SigninRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SigninRoute';

  static const _i6.PageInfo<SigninRouteArgs> page =
      _i6.PageInfo<SigninRouteArgs>(name);
}

class SigninRouteArgs {
  const SigninRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'SigninRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.SignupScreen]
class SignupRoute extends _i6.PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          SignupRoute.name,
          args: SignupRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i6.PageInfo<SignupRouteArgs> page =
      _i6.PageInfo<SignupRouteArgs>(name);
}

class SignupRouteArgs {
  const SignupRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.TaskInputScreen]
class TaskInputRoute extends _i6.PageRouteInfo<void> {
  const TaskInputRoute({List<_i6.PageRouteInfo>? children})
      : super(
          TaskInputRoute.name,
          initialChildren: children,
        );

  static const String name = 'TaskInputRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.TaskListScreen]
class TaskListRoute extends _i6.PageRouteInfo<void> {
  const TaskListRoute({List<_i6.PageRouteInfo>? children})
      : super(
          TaskListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TaskListRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.UserScreen]
class UserRoute extends _i6.PageRouteInfo<void> {
  const UserRoute({List<_i6.PageRouteInfo>? children})
      : super(
          UserRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
