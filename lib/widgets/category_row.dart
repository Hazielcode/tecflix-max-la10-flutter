/// ──────────────────────────────────────────────────────────────────────────────
/// category_row.dart — Widget reutilizable: fila horizontal de contenido.
///
/// Renderiza una categoría con título y un ListView.builder horizontal
/// de ContentCards.  Demuestra:
///   ✓ ListView.builder horizontal con rendimiento óptimo
///   ✓ Composición de widgets reutilizables
///   ✓ Paso de callbacks para navegación
/// ──────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data_model.dart';
import 'content_card.dart';

class CategoryRow extends StatelessWidget {
  final ContentCategory category;
  final void Function(Content content) onContentTap;

  const CategoryRow({
    super.key,
    required this.category,
    required this.onContentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Título de la categoría (fuente Poppins — títulos) ──
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            category.name,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),

        // ── Lista horizontal con ListView.builder (lazy rendering) ──
        // Solo renderiza las cards visibles + un buffer pequeño,
        // optimizando memoria en listas con muchos elementos.
        SizedBox(
          height: 200,
          child: ListView.builder(
            // Scroll horizontal estilo Netflix
            scrollDirection: Axis.horizontal,
            // BouncingScrollPhysics para efecto rebote suave
            physics: const BouncingScrollPhysics(),
            // itemCount permite a Flutter precalcular la extensión total
            itemCount: category.items.length,
            // Padding lateral para alinear con el título
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final content = category.items[index];
              return ContentCard(
                content: content,
                onTap: () => onContentTap(content),
              );
            },
          ),
        ),
      ],
    );
  }
}
