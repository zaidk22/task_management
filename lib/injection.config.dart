// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:task_management/blocs/auth/auth_bloc.dart' as _i10;
import 'package:task_management/blocs/task/task_bloc.dart' as _i11;
import 'package:task_management/blocs/users_bloc/users_bloc.dart' as _i7;
import 'package:task_management/data%20/repository/auth_impl.dart' as _i9;
import 'package:task_management/data%20/repository/task_impl.dart' as _i4;
import 'package:task_management/data%20/repository/user_impl.dart' as _i6;
import 'package:task_management/domain/repositories/i_auth_repo.dart' as _i8;
import 'package:task_management/domain/repositories/i_task_repo.dart' as _i3;
import 'package:task_management/domain/repositories/i_user_repo.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.ITaskRepository>(() => _i4.TaskRepository());
    gh.lazySingleton<_i5.IUserRepo>(() => _i6.UserRepository());
    gh.factory<_i7.UserBloc>(() => _i7.UserBloc(gh<_i5.IUserRepo>()));
    gh.lazySingleton<_i8.IAuthRepository>(() => _i9.AuthRepository());
    gh.factory<_i10.AuthBloc>(() => _i10.AuthBloc(gh<_i8.IAuthRepository>()));
    gh.factory<_i11.TaskBloc>(() => _i11.TaskBloc(gh<_i3.ITaskRepository>()));
    return this;
  }
}
