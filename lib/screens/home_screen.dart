import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/data/profile_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/custom_button.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient Circles
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.primaryAccent.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(duration: 1.seconds),
          Positioned(
            bottom: -50,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.secondaryAccent.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(duration: 1.seconds, delay: 300.ms),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 40.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.primaryAccent,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryAccent.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                        image: const DecorationImage(
                          image: NetworkImage(ProfileData.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).animate().scale(
                      duration: 600.ms,
                      curve: Curves.easeOutBack,
                    ),

                    const SizedBox(height: 24),

                    // Name
                    Text(
                          l10n.appName,
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 8),

                    // Title
                    Text(
                          l10n.homeTitle,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: AppTheme.secondaryAccent),
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 24),

                    // Intro Text
                    Text(
                          l10n.homeIntro,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .fadeIn(delay: 400.ms)
                        .slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 40),

                    // Buttons
                    Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.center,
                          children: [
                            CustomButton(
                              text: l10n.viewProjects,
                              icon: Icons.work_outline,
                              onPressed: () => context.go('/projects'),
                            ),
                            CustomButton(
                              text: l10n.downloadCv,
                              icon: Icons.download_rounded,
                              isPrimary: false,
                              onPressed: () => launchExternalUrl(
                                context: context,
                                urlString: ProfileData.cvUrl,
                              ),
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(delay: 600.ms)
                        .slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 96),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
