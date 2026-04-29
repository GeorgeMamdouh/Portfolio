import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/widgets/custom_button.dart';
import 'package:portfolio/widgets/responsive_layout.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProjectsScreenBody();
  }
}

class _ProjectsScreenBody extends StatefulWidget {
  const _ProjectsScreenBody();

  @override
  State<_ProjectsScreenBody> createState() => _ProjectsScreenBodyState();
}

class _ProjectsScreenBodyState extends State<_ProjectsScreenBody> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTech = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final projects = PortfolioData.getProjects(context);
    final techFilters = _buildTechFilters(projects);
    final filteredProjects = _filteredProjects(projects);

    return Scaffold(
      appBar: ResponsiveLayout.isMobile(context)
          ? null
          : AppBar(title: Text(l10n.featuredProjects)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: l10n.searchProjects,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final tag = techFilters[index];
                      final selected = _selectedTech == tag;
                      return ChoiceChip(
                        label: Text(tag == 'all' ? l10n.all : tag),
                        selected: selected,
                        onSelected: (_) => setState(() => _selectedTech = tag),
                        selectedColor: AppTheme.primaryAccent.withValues(
                          alpha: 0.2,
                        ),
                        side: BorderSide(
                          color: selected
                              ? AppTheme.primaryAccent
                              : Colors.white24,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemCount: techFilters.length,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 1;
                if (constraints.maxWidth >= 1200) {
                  crossAxisCount = 3;
                } else if (constraints.maxWidth >= 800) {
                  crossAxisCount = 2;
                }

                if (filteredProjects.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        l10n.noProjectsFound,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (crossAxisCount == 1) {
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 110),
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) {
                      return ProjectCard(project: filteredProjects[index])
                          .animate()
                          .fadeIn(delay: Duration(milliseconds: 100 * index))
                          .slideY(begin: 0.1, end: 0);
                    },
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 110),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    return ProjectCard(project: filteredProjects[index])
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 100 * index))
                        .slideY(begin: 0.1, end: 0);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<String> _buildTechFilters(List<Project> projects) {
    final tags = <String>{'all'};
    for (final project in projects) {
      final values = project.tech.split('+').map((tag) => tag.trim());
      tags.addAll(values.where((value) => value.isNotEmpty));
    }
    return tags.toList();
  }

  List<Project> _filteredProjects(List<Project> projects) {
    final query = _searchController.text.trim().toLowerCase();
    return projects.where((project) {
      final matchesTech =
          _selectedTech == 'all' || project.tech.contains(_selectedTech);
      final matchesText =
          query.isEmpty ||
          project.title.toLowerCase().contains(query) ||
          project.description.toLowerCase().contains(query) ||
          project.tech.toLowerCase().contains(query);
      return matchesTech && matchesText;
    }).toList();
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: ResponsiveLayout.isMobile(context)
          ? const EdgeInsets.only(bottom: 32)
          : EdgeInsets.zero,
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: 'project_image_${project.id}',
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.push('/project/${project.id}'),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    project.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.white10,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.white10,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image_outlined),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  project.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  project.tech,
                  style: const TextStyle(
                    color: AppTheme.secondaryAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: CustomButton(
                    text: l10n.viewDetails,
                    isPrimary: false,
                    onPressed: () => context.push('/project/${project.id}'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
