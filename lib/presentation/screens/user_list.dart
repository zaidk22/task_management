import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/users_bloc/users_bloc.dart';


@RoutePage()
class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
    
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('User List'),
          ),
          body: BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: CachedNetworkImage(imageUrl: user.avatar??"",
                  errorWidget: (context, url, error) => Icon(Icons.error,),
                  ),
                ),
                title: Text(user.firstName??""),
                subtitle: Text('Email: ${user.email??""}'),

              );
            },
          );
        } else if (state is UserError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    )
        ),
    );
  }
}

