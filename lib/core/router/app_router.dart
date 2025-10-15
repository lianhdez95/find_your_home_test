import 'package:find_your_home_test/modules/auth/presentation/pages/login_page.dart';
import 'package:find_your_home_test/modules/auth/presentation/pages/register_page.dart';
import 'package:find_your_home_test/modules/home/presentation/pages/home_page.dart';
import 'package:find_your_home_test/modules/splash/presentation/pages/splash_page.dart';
import 'package:find_your_home_test/shared/widgets/theme_example_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/theme',
      builder: (context, state) {
        return const ThemeExamplePage();
      },
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        return const RegisterPage();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final email = extra?['email'] as String?;
        final name = extra?['name'] as String?;
        return HomePage(email: email, name: name);
      },
    ),
  ],
);
