import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/data/profile_data.dart';
import 'package:portfolio/providers/locale_provider.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:portfolio/widgets/responsive_layout.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class MainNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigation({super.key, required this.navigationShell});

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  // Returns the navigationShell directly.
  // AnimatedSwitcher CANNOT wrap navigationShell — it holds both the old and
  // new child in the tree simultaneously during a transition, which causes
  // the shell's internal GlobalKeys to appear twice (Duplicate GlobalKey error).
  // Page-level transitions are already handled in app_router.dart.
  Widget _buildShell() => navigationShell;

  /// Builds the correct layout for the current breakpoint.
  /// The shell is constructed exactly once inside the chosen branch so the
  /// same GlobalKey never appears in two places simultaneously.
  Widget _buildResponsiveBody(
    BuildContext context,
    ThemeProvider themeProvider,
    LocaleProvider localeProvider,
    AppLocalizations l10n,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          // Tablet / Desktop — build the rail layout with a fresh shell.
          return _buildDesktopLayout(
            context,
            themeProvider,
            localeProvider,
            l10n,
            shell: _buildShell(),
          );
        }
        // Mobile — build the shell directly.
        return _buildShell();
      },
    );
  }

  void _showQuickActions(
    BuildContext context,
    ThemeProvider themeProvider,
    LocaleProvider localeProvider,
    AppLocalizations l10n,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _QuickActionChip(
                  icon: Icons.home,
                  label: l10n.navHome,
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _goBranch(0);
                  },
                ),
                _QuickActionChip(
                  icon: Icons.work,
                  label: l10n.navProjects,
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _goBranch(1);
                  },
                ),
                _QuickActionChip(
                  icon: Icons.code,
                  label: l10n.navSkills,
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _goBranch(2);
                  },
                ),
                _QuickActionChip(
                  icon: Icons.mail,
                  label: l10n.navContact,
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _goBranch(3);
                  },
                ),
                _QuickActionChip(
                  icon: Icons.language,
                  label: 'Language',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    localeProvider.toggleLocale();
                  },
                ),
                _QuickActionChip(
                  icon: themeProvider.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  label: themeProvider.isDarkMode ? 'Light mode' : 'Dark mode',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    themeProvider.toggleTheme();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: Text(l10n.appName),
              actions: [
                IconButton(
                  icon: const Icon(Icons.language),
                  onPressed: () => localeProvider.toggleLocale(),
                ),
                IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  onPressed: () => themeProvider.toggleTheme(),
                ),
              ],
            )
          : null,
      body: _buildResponsiveBody(
        context,
        themeProvider,
        localeProvider,
        l10n,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: isMobile
          ? FloatingActionButton.extended(
              onPressed: () => _showQuickActions(
                context,
                themeProvider,
                localeProvider,
                l10n,
              ),
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Quick actions'),
            )
          : null,
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: _goBranch,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  activeIcon: const Icon(Icons.home),
                  label: l10n.navHome,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.work_outline),
                  activeIcon: const Icon(Icons.work),
                  label: l10n.navProjects,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.code),
                  activeIcon: const Icon(Icons.code),
                  label: l10n.navSkills,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.mail_outline),
                  activeIcon: const Icon(Icons.mail),
                  label: l10n.navContact,
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ThemeProvider themeProvider,
    LocaleProvider localeProvider,
    AppLocalizations l10n, {
    required Widget shell,
  }) {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          labelType: NavigationRailLabelType.all,
          leading: const Padding(
            padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(ProfileData.avatarUrl),
            ),
          ),
          trailing: Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.language),
                      onPressed: () => localeProvider.toggleLocale(),
                    ),
                    IconButton(
                      icon: Icon(
                        themeProvider.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                      onPressed: () => themeProvider.toggleTheme(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          destinations: [
            NavigationRailDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: Text(l10n.navHome),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.work_outline),
              selectedIcon: const Icon(Icons.work),
              label: Text(l10n.navProjects),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.code_outlined),
              selectedIcon: const Icon(Icons.code),
              label: Text(l10n.navSkills),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.mail_outline),
              selectedIcon: const Icon(Icons.mail),
              label: Text(l10n.navContact),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: shell),
      ],
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }
}
