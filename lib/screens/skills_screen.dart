import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/widgets/responsive_layout.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final skillCategories = PortfolioData.getSkillCategories(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: ResponsiveLayout.isMobile(context)
          ? null
          : AppBar(title: Text(l10n.mySkills)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...skillCategories.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child:
                    _buildSkillCategory(
                          context,
                          category.title,
                          category.skills.map((s) {
                            return SkillItem(
                              name: s.name,
                              percentage: s.percentage,
                            );
                          }).toList(),
                        )
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 200 * index))
                        .slideX(begin: -0.05, end: 0),
              );
            }),
            const SizedBox(height: 96),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCategory(
    BuildContext context,
    String title,
    List<Widget> skills,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppTheme.primaryAccent),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.cards : AppTheme.lightCards,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(children: skills),
        ),
      ],
    );
  }
}

class SkillItem extends StatelessWidget {
  final String name;
  final double percentage;

  const SkillItem({super.key, required this.name, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                '\${(percentage * 100).toInt()}%',
                style: const TextStyle(color: AppTheme.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              // Background Bar
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Animated Progress Bar
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    height: 8,
                    width: constraints.maxWidth * percentage,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryAccent,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.secondaryAccent.withValues(
                            alpha: 0.5,
                          ),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ).animate().scaleX(
                    begin: 0,
                    end: 1,
                    alignment: Alignment.centerLeft,
                    duration: 1.seconds,
                    curve: Curves.easeOutQuart,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
