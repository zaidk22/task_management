import 'package:auto_route/auto_route.dart';

import './routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [

  
        CustomRoute(
            page: SigninRoute.page,
            transitionsBuilder: TransitionsBuilders.slideLeft,
        initial: true,
            durationInMilliseconds: 500),


 CustomRoute(
            page: SignupRoute.page,
            transitionsBuilder: TransitionsBuilders.slideLeft,
            durationInMilliseconds: 500),


 CustomRoute(
            page: TaskListRoute.page,
            transitionsBuilder: TransitionsBuilders.slideLeft,
            durationInMilliseconds: 500),

             CustomRoute(
            page: TaskInputRoute.page,
            transitionsBuilder: TransitionsBuilders.slideLeft,
            durationInMilliseconds: 500),

    CustomRoute(
            page: UserRoute.page,
            transitionsBuilder: TransitionsBuilders.slideLeft,
            durationInMilliseconds: 500),






      ];
}
