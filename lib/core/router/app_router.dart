import 'package:find_your_home_test/modules/auth/presentation/pages/login_page.dart';
import 'package:find_your_home_test/modules/auth/presentation/pages/register_page.dart';
import 'package:find_your_home_test/modules/home/presentation/pages/home_page.dart';
import 'package:find_your_home_test/modules/house/presentation/pages/house_page.dart';
import 'package:find_your_home_test/shared/widgets/theme_example_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/theme',
      builder: (context, state) {
        return const ThemeExamplePage();
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
    GoRoute(
      path: '/house/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final extra = state.extra as Map<String, dynamic>?;
        final email = extra?['email'] as String?;
        return HousePage(houseId: id, userEmail: email);
      },
    ),
  ],
);
