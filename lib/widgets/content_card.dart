/// ──────────────────────────────────────────────────────────────────────────────
/// content_card.dart — Widget reutilizable: tarjeta de contenido (poster).
///
/// Simula las tarjetas de película/serie tipo Netflix con imagen de fondo,
/// título superpuesto, badge de rating y micro-animación de escala al tocar.
/// ──────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data_model.dart';

class ContentCard extends StatefulWidget {
  final Content content;
  final VoidCallback onTap;
  final double width;
  final double height;

  const ContentCard({
    super.key,
    required this.content,
    required this.onTap,
    this.width = 140,
    this.height = 200,
  });

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    // Micro-animación de escala al mantener presionado (feedback táctil)
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ── Imagen poster ──
                Image.network(
                  widget.content.posterUrl,
                  fit: BoxFit.cover,
                  // Placeholder mientras carga
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: const Color(0xFF2A2A3E),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            Colors.red.shade400,
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stack) {
                    return Container(
                      color: const Color(0xFF2A2A3E),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.movie_outlined,
                            color: Colors.white.withOpacity(0.3),
                            size: 36,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.content.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // ── Gradiente inferior para legibilidad del texto ──
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 80,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.85),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Título superpuesto ──
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Text(
                    widget.content.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ),

                // ── Badge de rating (esquina superior derecha) ──
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded,
                            size: 12, color: Color(0xFFFFD700)),
                        const SizedBox(width: 2),
                        Text(
                          widget.content.rating.toStringAsFixed(1),
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Badge tipo (película/serie) ──
                if (widget.content.type == 'series')
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE50914),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'SERIE',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
