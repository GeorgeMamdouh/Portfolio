import 'package:flutter/material.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/data/profile_data.dart';
import 'package:portfolio/models/skill_model.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class PortfolioData {
  static List<Project> getProjects(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      Project(
        id: 'e-commerce-app',
        title: l10n.project1Title,
        tech: 'Flutter + Firebase',
        description: l10n.project1Desc,
        imageUrl:
            'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?q=80&w=600&auto=format&fit=crop',
        projectUrl: 'https://play.google.com/store',
        githubUrl: ProfileData.githubUrl,
        highlights: [
          l10n.project1Highlight1,
          l10n.project1Highlight2,
          l10n.project1Highlight3,
        ],
      ),
      Project(
        id: 'social-dashboard',
        title: l10n.project2Title,
        tech: 'Flutter + REST API',
        description: l10n.project2Desc,
        imageUrl:
            'https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=600&auto=format&fit=crop',
        githubUrl: ProfileData.githubUrl,
        highlights: [
          l10n.project2Highlight1,
          l10n.project2Highlight2,
          l10n.project2Highlight3,
        ],
      ),
      Project(
        id: 'fitness-tracker',
        title: l10n.project3Title,
        tech: 'Flutter + Local Storage',
        description: l10n.project3Desc,
        imageUrl:
            'https://images.unsplash.com/photo-1526506118432-6e27cb1c2aee?q=80&w=600&auto=format&fit=crop',
        githubUrl: ProfileData.githubUrl,
        highlights: [
          l10n.project3Highlight1,
          l10n.project3Highlight2,
          l10n.project3Highlight3,
        ],
      ),
    ];
  }

  static List<SkillCategory> getSkillCategories(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      SkillCategory(
        title: l10n.skillMobile,
        skills: const [
          Skill(name: 'Flutter', percentage: 0.95),
          Skill(name: 'Dart', percentage: 0.90),
          Skill(name: 'Kotlin', percentage: 0.75),
          Skill(name: 'Java', percentage: 0.75),
        ],
      ),
      SkillCategory(
        title: l10n.skillBackend,
        skills: const [
          Skill(name: 'Firebase', percentage: 0.85),
          Skill(name: 'REST API', percentage: 0.90),
          Skill(name: 'Node.js', percentage: 0.70),
        ],
      ),
      SkillCategory(
        title: l10n.skillTools,
        skills: const [
          Skill(name: 'UI/UX', percentage: 0.90),
          Skill(name: 'Figma', percentage: 0.85),
          Skill(name: 'Git', percentage: 0.80),
          Skill(name: 'Supabase', percentage: 0.65),
        ],
      ),
    ];
  }
}
