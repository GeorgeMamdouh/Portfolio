import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color background = Color(0xFF0D0D0D); // Deep Black
  static const Color cards = Color(0xFF1A1A1A);
  static const Color primaryAccent = Color(0xFF6C63FF); // Purple Blue
  static const Color secondaryAccent = Color(0xFF00C9A7);
  static const Color textMain = Colors.white;
  static const Color textSecondary = Color(0xFFB3B3B3); // Light Gray

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF5F5F7);
  static const Color lightCards = Colors.white;
  static const Color lightTextMain = Color(0xFF1D1D1F);
  static const Color lightTextSecondary = Color(0xFF86868B);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primaryAccent,
      colorScheme: const ColorScheme.dark(
        primary: primaryAccent,
        secondary: secondaryAccent,
        surface: cards,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.poppins(
              color: textMain,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: GoogleFonts.poppins(
              color: textMain,
              fontWeight: FontWeight.bold,
            ),
            displaySmall: GoogleFonts.poppins(
              color: textMain,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: GoogleFonts.poppins(
              color: textMain,
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: GoogleFonts.poppins(
              color: textMain,
              fontWeight: FontWeight.w600,
            ),
            titleLarge: GoogleFonts.poppins(
              color: textMain,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: GoogleFonts.poppins(color: textMain),
            bodyMedium: GoogleFonts.poppins(color: textMain),
            bodySmall: GoogleFonts.poppins(color: textSecondary),
          ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cards,
        selectedItemColor: primaryAccent,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
      cardTheme: CardThemeData(
        color: cards,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: primaryAccent,
      colorScheme: const ColorScheme.light(
        primary: primaryAccent,
        secondary: secondaryAccent,
        surface: lightCards,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.poppins(
              color: lightTextMain,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: GoogleFonts.poppins(
              color: lightTextMain,
              fontWeight: FontWeight.bold,
            ),
            displaySmall: GoogleFonts.poppins(
              color: lightTextMain,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: GoogleFonts.poppins(
              color: lightTextMain,
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: GoogleFonts.poppins(
              color: lightTextMain,
              fontWeight: FontWeight.w600,
            ),
            titleLarge: GoogleFonts.poppins(
              color: lightTextMain,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: GoogleFonts.poppins(color: lightTextMain),
            bodyMedium: GoogleFonts.poppins(color: lightTextMain),
            bodySmall: GoogleFonts.poppins(color: lightTextSecondary),
          ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: lightTextMain),
        titleTextStyle: TextStyle(
          color: lightTextMain,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightCards,
        selectedItemColor: primaryAccent,
        unselectedItemColor: lightTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
      cardTheme: CardThemeData(
        color: lightCards,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
      ),
    );
  }
}
