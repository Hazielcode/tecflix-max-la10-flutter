import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data_model.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final content = ModalRoute.of(context)!.settings.arguments as Content;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackdrop(content),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(content.title, style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, height: 1.15)),
                  const SizedBox(height: 12),
                  _buildMetadataRow(content),
                  const SizedBox(height: 16),
                  _buildPlayButton(),
                  const SizedBox(height: 20),
                  Text(content.overview, style: GoogleFonts.inter(fontSize: 14, height: 1.7, color: Colors.white.withOpacity(0.8))),
                  const SizedBox(height: 8),
                  Text('Géneros: ${content.genres.join(', ')}', style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withOpacity(0.5))),
                  const SizedBox(height: 28),
                  Text('REPARTO', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.6), letterSpacing: 2)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: content.cast.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) => _buildCastCard(content.cast[index]),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DATOS TÉCNICOS', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.6), letterSpacing: 2)),
                  const SizedBox(height: 12),
                  _buildJsonBlock(content),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('TAMBIÉN TE PUEDE GUSTAR', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.6), letterSpacing: 2)),
            ),
            const SizedBox(height: 12),
            _buildSimilarContent(context, content),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBackdrop(Content content) {
    return SizedBox(
      height: 340,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(content.backdropUrl, fit: BoxFit.cover,
            loadingBuilder: (c, child, p) => p == null ? child : Container(color: const Color(0xFF1A1A2E)),
            errorBuilder: (c, e, s) => Container(color: const Color(0xFF1A1A2E), child: Center(child: Icon(Icons.movie_outlined, color: Colors.white.withOpacity(0.15), size: 80))),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [0.0, 0.5, 1.0],
                colors: [Colors.transparent, Colors.black.withOpacity(0.3), const Color(0xFF0A0A0F)],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 64, height: 64,
              decoration: BoxDecoration(color: const Color(0xFFE50914).withOpacity(0.9), shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: const Color(0xFFE50914).withOpacity(0.4), blurRadius: 20, spreadRadius: 2)],
              ),
              child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataRow(Content content) {
    return Wrap(
      spacing: 12, runSpacing: 8, crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('${content.year}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.7))),
        Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFD700)),
          const SizedBox(width: 4),
          Text(content.rating.toStringAsFixed(1), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
        ]),
        Text(content.duration, style: GoogleFonts.inter(fontSize: 14, color: Colors.white.withOpacity(0.7))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.3)), borderRadius: BorderRadius.circular(4)),
          child: Text(content.maturity, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.7))),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: content.type == 'series' ? const Color(0xFFE50914) : const Color(0xFF6C63FF), borderRadius: BorderRadius.circular(4)),
          child: Text(content.type == 'series' ? 'SERIE' : 'PELÍCULA', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.5)),
        ),
      ],
    );
  }

  Widget _buildPlayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.play_arrow_rounded, size: 24),
        label: Text('Reproducir', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16)),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      ),
    );
  }

  Widget _buildCastCard(CastMember member) {
    return Container(
      width: 90, margin: const EdgeInsets.only(right: 14),
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(member.photoUrl, width: 68, height: 68, fit: BoxFit.cover,
            loadingBuilder: (c, child, p) => p == null ? child : Container(width: 68, height: 68, decoration: const BoxDecoration(color: Color(0xFF2A2A3E), shape: BoxShape.circle)),
            errorBuilder: (c, e, s) => Container(width: 68, height: 68, decoration: const BoxDecoration(color: Color(0xFF2A2A3E), shape: BoxShape.circle), child: Icon(Icons.person_rounded, color: Colors.white.withOpacity(0.3), size: 28)),
          ),
        ),
        const SizedBox(height: 8),
        Text(member.name, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white)),
        Text(member.role, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 9, color: Colors.white.withOpacity(0.5))),
      ]),
    );
  }

  Widget _buildJsonBlock(Content content) {
    final jsonMap = content.toJson();
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withOpacity(0.06))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('// Content.toJson()', style: GoogleFonts.firaCode(fontSize: 11, color: const Color(0xFF676E95))),
        const SizedBox(height: 8),
        ...jsonMap.entries.map((entry) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: RichText(text: TextSpan(style: GoogleFonts.firaCode(fontSize: 12), children: [
            TextSpan(text: '"${entry.key}"', style: const TextStyle(color: Color(0xFFC792EA))),
            const TextSpan(text: ': ', style: TextStyle(color: Color(0xFF89DDFF))),
            TextSpan(text: entry.value is String ? '"${entry.value}"' : '${entry.value}',
              style: TextStyle(color: entry.value is String ? const Color(0xFFC3E88D) : const Color(0xFFF78C6C))),
          ])),
        )),
      ]),
    );
  }

  Widget _buildSimilarContent(BuildContext context, Content current) {
    final allContent = parseAllContent(mockCatalogResponse);
    final similar = allContent.where((c) => c.id != current.id && c.genres.any((g) => current.genres.contains(g))).toList();
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
        itemCount: similar.length, padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          final item = similar[index];
          return GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, '/details', arguments: item),
            child: Container(
              width: 120, margin: const EdgeInsets.only(right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(fit: StackFit.expand, children: [
                  Image.network(item.posterUrl, fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(color: const Color(0xFF2A2A3E), child: Center(child: Text(item.title, textAlign: TextAlign.center, maxLines: 2, style: GoogleFonts.inter(fontSize: 10, color: Colors.white.withOpacity(0.4)))))),
                  Positioned(bottom: 0, left: 0, right: 0, child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.8)])),
                    child: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white)),
                  )),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
