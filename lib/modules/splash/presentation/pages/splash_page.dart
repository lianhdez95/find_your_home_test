import 'package:find_your_home_test/modules/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  VideoPlayerController? _controller;
  bool _isVideoInitialized = false;
  bool _navigated = false; // evita múltiples navegaciones
  final bool _mute = true; // bandera para controlar audio (true = sin sonido)
  late final Stopwatch _stopwatch; // para métricas opcionales

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    _initVideo();
    // Timer para mostrar botón Skip
    
  }

  Future<void> _initVideo() async {
    try {
      final controller = VideoPlayerController.asset(
        'assets/video/grok-video-f1881c61-a3ec-457e-a396-ebfc5d57f223.mp4',
        videoPlayerOptions: VideoPlayerOptions()
      );
      _controller = controller;
      await controller.initialize();
      // Silenciar antes de reproducir
      if (_mute) {
        try {
          await controller.setVolume(0);
        } catch (e) {
          debugPrint('No se pudo mutear el video: $e');
        }
      }
      if (!mounted) return;
      setState(() => _isVideoInitialized = true);

      controller.addListener(_videoListener);
      await controller.play();
    } catch (e) {
      debugPrint('Splash video error: $e');
      // Fallback tras 3s
      Future.delayed(const Duration(seconds: 3), _navigateToLogin);
    }
  }

  void _videoListener() {
    final c = _controller;
    if (c == null) return;
    if (c.value.isInitialized && !c.value.isPlaying &&
        c.value.position >= c.value.duration && !_navigated) {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    if (_navigated) return;
    _navigated = true;
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashView(
        controller: _controller,
        isVideoInitialized: _isVideoInitialized,
        onTap: _navigateToLogin,
        onSkip: _navigateToLogin,
        loadingText: 'Cargando...',
        tapToContinueText: 'Toca para continuar',
      ),
    );
  }
}