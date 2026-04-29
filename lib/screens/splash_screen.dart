import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/l10n/app_localizations.dart';
import 'package:portfolio/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2200), () {
      if (mounted) {
        context.go('/');
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF13151A), Color(0xFF1A1D24)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppTheme.primaryAccent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.primaryAccent.withValues(alpha: 0.45),
                  ),
                ),
                child: const Icon(
                  Icons.flutter_dash_rounded,
                  color: AppTheme.primaryAccent,
                  size: 66,
                ),
              ).animate().scale(duration: 700.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 24),
              Text(
                l10n.appName,
                style: Theme.of(context).textTheme.headlineMedium,
              ).animate().fadeIn(delay: 220.ms),
              const SizedBox(height: 8),
              Text(
                l10n.splashTagline,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppTheme.textSecondary),
              ).animate().fadeIn(delay: 380.ms),
              const SizedBox(height: 30),
              SizedBox(
                width: 170,
                child: LinearProgressIndicator(
                  color: AppTheme.primaryAccent,
                  backgroundColor: Colors.white12,
                  borderRadius: BorderRadius.circular(20),
                  minHeight: 6,
                ),
              ).animate().fadeIn(delay: 500.ms),
            ],
          ),
        ),
      ),
    );
  }
}
