import 'package:find_your_home_test/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? description;
  final String confirmText;
  final IconData? iconData;
  final Color? color;
  final VoidCallback onConfirm;

  const AppDialog({
    super.key,
    required this.title,
    required this.confirmText,
    required this.onConfirm,
    this.description,
    this.iconData,
    this.color,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String confirmText,
    required VoidCallback onConfirm,
    IconData? iconData,
    String? description,
    Color? color,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AppDialog(
        title: title,
        description: description,
        confirmText: confirmText,
        iconData: iconData,
        onConfirm: onConfirm,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 650),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(scale: value, child: child);
              },
              child: iconData != null
                  ? Icon(iconData, color: color ?? context.successColor, size: 100)
                  : Container(),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color ?? context.primaryBlue
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
                child: Text(confirmText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
