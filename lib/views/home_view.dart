/// ──────────────────────────────────────────────────────────────────────────────
/// home_view.dart — Pantalla principal de Tecflix Max (estilo Netflix/HBO Max).
///
/// Estructura:
///   1. Hero banner con el contenido destacado
///   2. Filas horizontales de categorías (ListView.builder horizontal)
///   3. AppBar transparente con logo y botón de perfil
///
/// Demuestra:
///   ✓ ListView.builder (vertical + horizontal anidados)
///   ✓ ListTiles personalizados
///   ✓ Manipulación de Listas y Mapas (.map, .where, .toList)
///   ✓ Navegación con rutas nombradas + argumentos
///   ✓ Cards modernas con gradientes
/// ──────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data_model.dart';
import '../widgets/category_row.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Parseamos la respuesta mock una sola vez (simula llamada API)
  late final List<Content> _allContent;
  late final List<ContentCategory> _categories;
  late final Content _featured;

  @override
  void initState() {
    super.initState();
    // .map() + .toList() para convertir raw Maps → modelos tipados
    _allContent = parseAllContent(mockCatalogResponse);
    // Construye categorías usando .where(), .fold(), .toList()
    _categories = buildCategories(_allContent);
    // El contenido destacado es el mejor valorado
    _featured = getTopRated(_allContent, minRating: 9.0).first;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // Fondo completamente negro (estilo streaming)
      backgroundColor: const Color(0xFF0A0A0F),
      // Eliminamos el AppBar default — usamos un overlay custom
      extendBodyBehindAppBar: true,
      appBar: _buildTransparentAppBar(),
      body: ListView.builder(
        // BouncingScrollPhysics para un scroll premium
        physics: const BouncingScrollPhysics(),
        // +1 por el hero banner al inicio
        itemCount: _categories.length + 1,
        itemBuilder: (context, index) {
          // ── Primer item: Hero Banner ──
          if (index == 0) {
            return _buildHeroBanner(screenWidth);
          }
          // ── Resto: Filas de categorías ──
          final category = _categories[index - 1];
          return CategoryRow(
            category: category,
            onContentTap: (content) {
              // Navegación con ruta nombrada + paso de argumentos tipados
              Navigator.pushNamed(
                context,
                '/details',
                arguments: content,
              );
            },
          );
        },
      ),

      // ── Bottom Navigation Bar estilo streaming ──
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // AppBar transparente superpuesto al contenido
  // ═══════════════════════════════════════════════════════════════════════════
  PreferredSizeWidget _buildTransparentAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          // Logo de Tecflix Max
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE50914), Color(0xFFB20710)],
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'T',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'TECFLIX',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          Text(
            ' MAX',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: const Color(0xFFE50914),
              letterSpacing: 2,
            ),
          ),
        ],
      ),
      actions: [
        // Botón de búsqueda
        IconButton(
          icon: const Icon(Icons.search_rounded, color: Colors.white),
          onPressed: () {
            // Placeholder — funcionalidad de búsqueda
          },
        ),
        // Avatar de perfil
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFE50914),
            child: Text(
              'U',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Hero Banner — Contenido destacado (estilo Netflix)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeroBanner(double screenWidth) {
    return SizedBox(
      height: 480,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Imagen de fondo (backdrop) ──
          Image.network(
            _featured.backdropUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(color: const Color(0xFF1A1A2E));
            },
            errorBuilder: (context, error, stack) {
              return Container(
                color: const Color(0xFF1A1A2E),
                child: Center(
                  child: Icon(
                    Icons.movie_creation_outlined,
                    color: Colors.white.withOpacity(0.2),
                    size: 80,
                  ),
                ),
              );
            },
          ),

          // ── Gradiente oscuro desde abajo para legibilidad ──
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.4, 0.7, 1.0],
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                  const Color(0xFF0A0A0F),
                ],
              ),
            ),
          ),

          // ── Contenido superpuesto al hero ──
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge "Contenido Destacado"
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE50914),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '★ DESTACADO',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Título (Poppins — títulos)
                Text(
                  _featured.title,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.1,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),

                // Metadatos: año · rating · duración
                Row(
                  children: [
                    Text(
                      '${_featured.year}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    _dot(),
                    const Icon(Icons.star_rounded,
                        size: 14, color: Color(0xFFFFD700)),
                    const SizedBox(width: 3),
                    Text(
                      _featured.rating.toStringAsFixed(1),
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    _dot(),
                    Text(
                      _featured.duration,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    _dot(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white.withOpacity(0.4), width: 1),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        _featured.maturity,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Géneros (usando .join() sobre List)
                Text(
                  _featured.genres.join(' · '),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 14),

                // Descripción (Inter — cuerpo)
                Text(
                  _featured.overview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.white.withOpacity(0.75),
                  ),
                ),
                const SizedBox(height: 16),

                // Botones de acción
                Row(
                  children: [
                    // Botón "Reproducir"
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: _featured,
                        );
                      },
                      icon: const Icon(Icons.play_arrow_rounded, size: 22),
                      label: Text(
                        'Reproducir',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Botón "Mi Lista"
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded, size: 20),
                      label: Text(
                        'Mi Lista',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                            color: Colors.white.withOpacity(0.5), width: 1.5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Bottom Navigation Bar (estilo streaming app)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0F),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFF0A0A0F),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.4),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 10),
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_rounded),
            label: 'Descargas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  // ── Separador tipo punto ──
  Widget _dot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '·',
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
