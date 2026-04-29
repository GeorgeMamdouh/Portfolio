import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/screens/contact_screen.dart';
import 'package:portfolio/screens/home_screen.dart';
import 'package:portfolio/screens/main_navigation.dart';
import 'package:portfolio/screens/project_detail_screen.dart';
import 'package:portfolio/screens/projects_screen.dart';
import 'package:portfolio/screens/splash_screen.dart';
import 'package:portfolio/screens/skills_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final GlobalKey<NavigatorState> _shellNavigatorProjects =
      GlobalKey<NavigatorState>(debugLabel: 'shellProjects');
  static final GlobalKey<NavigatorState> _shellNavigatorSkills =
      GlobalKey<NavigatorState>(debugLabel: 'shellSkills');
  static final GlobalKey<NavigatorState> _shellNavigatorContact =
      GlobalKey<NavigatorState>(debugLabel: 'shellContact');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) =>
            _buildTransitionPage(state: state, child: const SplashScreen()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: [
              GoRoute(
                path: '/',
                pageBuilder: (context, state) => _buildTransitionPage(
                  state: state,
                  child: const HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProjects,
            routes: [
              GoRoute(
                path: '/projects',
                pageBuilder: (context, state) => _buildTransitionPage(
                  state: state,
                  child: const ProjectsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSkills,
            routes: [
              GoRoute(
                path: '/skills',
                pageBuilder: (context, state) => _buildTransitionPage(
                  state: state,
                  child: const SkillsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorContact,
            routes: [
              GoRoute(
                path: '/contact',
                pageBuilder: (context, state) => _buildTransitionPage(
                  state: state,
                  child: const ContactScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/project/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return _buildTransitionPage(
            state: state,
            child: ProjectDetailScreen(projectId: id),
          );
        },
      ),
    ],
  );

  static CustomTransitionPage<void> _buildTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 260),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetTween = Tween<Offset>(
          begin: const Offset(0.04, 0),
          end: Offset.zero,
        );
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offsetTween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
