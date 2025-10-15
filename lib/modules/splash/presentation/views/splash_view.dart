import 'package:find_your_home_test/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:find_your_home_test/l10n/generated/app_localizations.dart';

/// Vista stateless que muestra el splash. Toda la lógica de estado
/// (controlador de video, timers, navegación) vive fuera (en la Page o un BLoC).
class SplashView extends StatelessWidget {
  final VideoPlayerController? controller;
  final bool isVideoInitialized;
  final VoidCallback onTap;
  final VoidCallback onSkip;
  final String? loadingText;
  final String? tapToContinueText;
  final Widget? overlay; // Permite inyectar overlays custom (branding)

  const SplashView({
    super.key,
    required this.controller,
    required this.isVideoInitialized,
    required this.onTap,
    required this.onSkip,
    this.loadingText,
    this.tapToContinueText,
    this.overlay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: context.colorScheme.surface,
        child: Stack(
          children: [
            // Video de fondo
            if (isVideoInitialized && controller != null && controller!.value.isInitialized)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller!.value.size.width,
                    height: controller!.value.size.height,
                    child: VideoPlayer(controller!),
                  ),
                ),
              ),
            
            // Overlay con gradiente para legibilidad
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),


            // Indicador de carga
            if (!isVideoInitialized)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        context.primaryBlue,
                      ),
                    ),
                    AppSpacing.verticalMD,
                    Text(
                      loadingText ?? AppLocalizations.of(context)?.splashLoading ?? '...',
                      style: context.bodyMedium.copyWith(
                        color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

            // Instrucción de tap (si se provee texto externo usarlo, si no localizar)
            
          ],
        ),
      ),
    );
  }
}


