/// ──────────────────────────────────────────────────────────────────────────────
/// main.dart — Tecflix Max: Punto de entrada de la aplicación.
///
/// Configuración centralizada de:
///   ✓ Tema Global (ThemeData) oscuro estilo streaming
///   ✓ 3 familias tipográficas: Poppins (títulos), Inter (cuerpo), Fira Code (código)
///   ✓ Dark / Light mode implícito (ThemeMode.system)
///   ✓ Sistema de rutas nombradas
/// ──────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'views/home_view.dart';
import 'views/details_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Barra de estado transparente para integración con el hero banner
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const TecflixMaxApp());
}

class TecflixMaxApp extends StatelessWidget {
  const TecflixMaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tecflix Max',
      debugShowCheckedModeBanner: false,

      // ── Tema principal (oscuro por defecto, estilo streaming) ──
      theme: _buildDarkTheme(),
      darkTheme: _buildDarkTheme(),

      // ── Modo automático ──
      themeMode: ThemeMode.system,

      // ── Rutas nombradas centralizadas ──
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeView(),
        '/details': (_) => const DetailsView(),
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TEMA OSCURO (streaming style — Netflix/HBO Max)
  // ═══════════════════════════════════════════════════════════════════════════
  ThemeData _buildDarkTheme() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: const Color(0xFFE50914), // Rojo Tecflix
    );

    return base.copyWith(
      // ── Tipografía con las 3 fuentes ──
      textTheme: _buildTextTheme(),

      // ── Fondo negro profundo (estilo streaming) ──
      scaffoldBackgroundColor: const Color(0xFF0A0A0F),

      // ── Cards con estilo premium ──
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color(0xFF1A1A2E),
        surfaceTintColor: Colors.transparent,
      ),

      // ── AppBar transparente ──
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),

      // ── ListTile personalizado ──
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // ── FAB estilizado ──
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: const Color(0xFFE50914),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // ── Bottom Nav ──
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0A0A0F),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SISTEMA TIPOGRÁFICO — 3 FUENTES
  //
  // 1. Poppins   → Títulos (headlines, titles)
  // 2. Inter     → Cuerpo / texto general (body, labels)
  // 3. Fira Code → Monospace (datos técnicos, código)
  // ═══════════════════════════════════════════════════════════════════════════
  TextTheme _buildTextTheme() {
    return TextTheme(
      // ── Poppins: Títulos ──
      headlineLarge: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5),
      headlineMedium: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
      headlineSmall: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      titleLarge: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      titleMedium: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      titleSmall: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),

      // ── Inter: Cuerpo / texto general ──
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white, height: 1.6),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white, height: 1.5),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.7), height: 1.5),

      // ── Inter: Labels ──
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
      labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),

      // ── Fira Code: Monospace ──
      labelSmall: GoogleFonts.firaCode(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.7)),
    );
  }
}
