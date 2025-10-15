import 'package:find_your_home_test/core/router/app_router.dart';
import 'package:find_your_home_test/core/theme/app_theme.dart';
import 'package:find_your_home_test/core/startup/startup_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shared/theme/theme_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/generated/app_localizations.dart';
import 'package:find_your_home_test/di/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupDependencies();
  await locator.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Warm-up del file system tras el primer frame para evitar fallos de path_provider en caches.
    // Se ejecuta una sola vez por arranque.
    WidgetsBinding.instance.addPostFrameCallback((_) => warmUpFileSystem());
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // El título se obtiene dinámicamente de localizaciones (usado en Android task switcher)
  onGenerateTitle: (context) => AppLocalizations.of(context)?.appTitle ?? 'App',
      routerConfig: routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      builder: (context, child) {
        // Aplicamos escalado tipográfico dinámico una sola vez aquí.
        final theme = Theme.of(context);
        final scaledTextTheme = scaleTextTheme(context, theme.textTheme);
        return Theme(
          data: theme.copyWith(textTheme: scaledTextTheme),
          child: child!,
        );
      },
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
          );
        },
      ),
    );
  }
}