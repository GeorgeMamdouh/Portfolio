import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/custom_button.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class ProjectDetailScreen extends StatelessWidget {
  final String projectId;

  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    final projects = PortfolioData.getProjects(context);
    final l10n = AppLocalizations.of(context)!;

    // Find the project by id
    final Project project = projects.firstWhere(
      (p) => p.id == projectId,
      orElse: () => projects.first, // Fallback
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'project_image_\${project.id}',
                child: Image.network(
                  project.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.black26,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black26,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image_outlined),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0),

                  const SizedBox(height: 8),

                  Text(
                    project.tech,
                    style: const TextStyle(
                      color: AppTheme.secondaryAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),

                  const SizedBox(height: 24),

                  Text(
                    l10n.aboutProject,
                    style: Theme.of(context).textTheme.titleLarge,
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 12),

                  Text(
                    project.description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.6),
                  ).animate().fadeIn(delay: 300.ms),

                  const SizedBox(height: 32),

                  if (project.highlights.isNotEmpty) ...[
                    Text(
                      l10n.keyFeatures,
                      style: Theme.of(context).textTheme.titleLarge,
                    ).animate().fadeIn(delay: 400.ms),

                    const SizedBox(height: 16),

                    ...project.highlights
                        .map((highlight) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: AppTheme.primaryAccent,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    highlight,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                        .toList()
                        .animate()
                        .fadeIn(delay: 500.ms),
                  ],

                  const SizedBox(height: 48),

                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      if (project.projectUrl != null)
                        CustomButton(
                          text: l10n.visitLive,
                          icon: Icons.open_in_new,
                          onPressed: () => launchExternalUrl(
                            context: context,
                            urlString: project.projectUrl!,
                          ),
                        ),
                      if (project.githubUrl != null)
                        CustomButton(
                          text: l10n.sourceCode,
                          icon: Icons.code,
                          isPrimary: false,
                          onPressed: () => launchExternalUrl(
                            context: context,
                            urlString: project.githubUrl!,
                          ),
                        ),
                    ],
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
