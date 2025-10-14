import 'package:find_your_home_test/modules/splash/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashPage();
      },
    ),
  ],
);
