// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/providers/locale_provider.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Theme and locale providers are available in widget tree', (
    WidgetTester tester,
  ) async {
    ThemeMode? observedThemeMode;
    Locale? observedLocale;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: Builder(
          builder: (context) {
            final themeProvider = context.watch<ThemeProvider>();
            final localeProvider = context.watch<LocaleProvider>();

            observedThemeMode = themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light;
            observedLocale = localeProvider.locale;

            return const MaterialApp(home: SizedBox.shrink());
          },
        ),
      ),
    );
    await tester.pump();

    expect(observedThemeMode, isNotNull);
    expect(observedLocale, isNotNull);
  });
}
