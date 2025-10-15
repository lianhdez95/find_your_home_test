import 'package:flutter/material.dart';
import '../../core/theme/theme_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/theme_cubit.dart';

/// Página de ejemplo que muestra el uso del tema personalizado
class ThemeExamplePage extends StatelessWidget {
  const ThemeExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Tema'),
        actions: [
          IconButton(
            icon: Icon(context.isDarkTheme ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              context.read<ThemeCubit>().toggle();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de colores
            Text(
              'Paleta de Colores',
              style: context.headlineMedium,
            ),
            AppSpacing.verticalMD,
            
            Row(
              children: [
                _ColorCard(
                  color: context.primaryBlue,
                  title: 'Azul Primario',
                ),
                AppSpacing.horizontalMD,
                _ColorCard(
                  color: context.lightBlue,
                  title: 'Azul Claro',
                ),
                AppSpacing.horizontalMD,
                _ColorCard(
                  color: context.mediumBlue,
                  title: 'Azul Medio',
                ),
              ],
            ),
            
            AppSpacing.verticalLG,
            
            // Sección de tipografía
            Text(
              'Tipografía (Rubik)',
              style: context.headlineMedium,
            ),
            AppSpacing.verticalMD,
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Display Large', style: context.displayLarge),
                Text('Headline Medium', style: context.headlineMedium),
                Text('Title Large', style: context.titleLarge),
                Text('Body Large', style: context.bodyLarge),
                Text('Body Medium', style: context.bodyMedium),
                Text('Label Small', style: context.labelSmall),
              ],
            ),
            
            AppSpacing.verticalLG,
            
            // Sección de botones
            Text(
              'Botones',
              style: context.headlineMedium,
            ),
            AppSpacing.verticalMD,
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Botón Elevado'),
                ),
                AppSpacing.verticalSM,
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Botón Outlined'),
                ),
                AppSpacing.verticalSM,
                TextButton(
                  onPressed: () {},
                  child: const Text('Botón de Texto'),
                ),
              ],
            ),
            
            AppSpacing.verticalLG,
            
            // Sección de campos de texto
            Text(
              'Campos de Texto',
              style: context.headlineMedium,
            ),
            AppSpacing.verticalMD,
            
            Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    hintText: 'Ingresa tu nombre',
                  ),
                ),
                AppSpacing.verticalMD,
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'correo@ejemplo.com',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ],
            ),
            
            AppSpacing.verticalLG,
            
            // Sección de tarjetas
            Text(
              'Tarjetas',
              style: context.headlineMedium,
            ),
            AppSpacing.verticalMD,
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tarjeta de Ejemplo',
                      style: context.titleLarge,
                    ),
                    AppSpacing.verticalSM,
                    Text(
                      'Esta es una tarjeta con el tema personalizado aplicado. '
                      'Usa colores y tipografía consistentes.',
                      style: context.bodyMedium,
                    ),
                    AppSpacing.verticalMD,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Cancelar'),
                        ),
                        AppSpacing.horizontalSM,
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Aceptar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            AppSpacing.verticalLG,
            
            // Sección de estados
            Text(
              'Estados de Color',
              style: context.headlineMedium,
            ),
            AppSpacing.verticalMD,
            
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.successColor,
                      borderRadius: AppBorderRadius.medium,
                    ),
                    child: Text(
                      'Éxito',
                      style: context.bodyMedium.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                AppSpacing.horizontalSM,
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.warningColor,
                      borderRadius: AppBorderRadius.medium,
                    ),
                    child: Text(
                      'Advertencia',
                      style: context.bodyMedium.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                AppSpacing.horizontalSM,
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.errorColor,
                      borderRadius: AppBorderRadius.medium,
                    ),
                    child: Text(
                      'Error',
                      style: context.bodyMedium.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorCard extends StatelessWidget {
  final Color color;
  final String title;

  const _ColorCard({
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppBorderRadius.medium,
          boxShadow: AppShadows.light,
        ),
        child: Center(
          child: Text(
            title,
            style: context.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}