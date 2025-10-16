import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Botón de favorito con animación de "latido" cuando se marca como favorito.
class AnimatedFavoriteButton extends StatefulWidget {
  const AnimatedFavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
    this.size = 28,
    this.activeColor = Colors.redAccent,
    this.inactiveColor = Colors.white,
    this.enableRipple = true,
    this.enableHaptics = true,
    this.enableShadows = false,
  });

  final bool isFavorite;
  final VoidCallback? onTap;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final bool enableRipple;
  final bool enableHaptics;
  final bool enableShadows;

  @override
  State<AnimatedFavoriteButton> createState() => _AnimatedFavoriteButtonState();
}

class _AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _rippleScaleAnim;
  late final Animation<double> _rippleOpacityAnim;

  bool _prevIsFavorite = false;

  @override
  void initState() {
    super.initState();
    _prevIsFavorite = widget.isFavorite;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    // Pulso: sube a 1.25 y vuelve a 1.0
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.25).chain(
          CurveTween(curve: Curves.easeOutBack),
        ),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.25, end: 1.0).chain(
          CurveTween(curve: Curves.easeIn),
        ),
        weight: 40,
      ),
    ]).animate(_controller);

    // Ripple sutil al marcar favorito
    _rippleScaleAnim = Tween<double>(begin: 0.6, end: 1.8)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_controller);
    _rippleOpacityAnim = Tween<double>(begin: 0.35, end: 0.0)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedFavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Dispara la animación cuando cambia de no favorito -> favorito
    if (!_prevIsFavorite && widget.isFavorite) {
      _controller.forward(from: 0);
      if (widget.enableHaptics) {
        HapticFeedback.lightImpact();
      }
    }
    _prevIsFavorite = widget.isFavorite;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.isFavorite ? Icons.favorite : Icons.favorite_border;
    final color = widget.isFavorite ? widget.activeColor : widget.inactiveColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: SizedBox(
        width: widget.size * 2,
        height: widget.size * 2,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            if (widget.enableRipple)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ClipOval(
                    child: Opacity(
                      opacity: _rippleOpacityAnim.value,
                      child: Transform.scale(
                        scale: _rippleScaleAnim.value,
                        child: Container(
                          width: widget.size,
                          height: widget.size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (widget.activeColor).withAlpha(51),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            if (widget.enableShadows)
              Transform.translate(
                offset: const Offset(0, -5),
                child: Material(
                  type: MaterialType.circle,
                  elevation: 6,
                  color: Colors.transparent,
                  shadowColor: const Color.fromRGBO(0, 0, 0, 0.35),
                  child: SizedBox(
                    width: widget.size + 10,
                    height: widget.size + 10,
                  ),
                ),
              ),
            ScaleTransition(
              scale: _scaleAnim,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOutBack,
                switchOutCurve: Curves.easeInBack,
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: child,
                ),
                child: Icon(
                  key: ValueKey<bool>(widget.isFavorite),
                  icon,
                  color: color,
                  size: widget.size,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
