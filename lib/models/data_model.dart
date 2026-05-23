/// ──────────────────────────────────────────────────────────────────────────────
/// data_model.dart — Modelos de datos que simulan respuestas JSON / API
/// de un servicio de streaming (Tecflix Max).
///
/// Combina **Listas** y **Mapas** para representar el catálogo de contenido
/// tal como llegaría desde un backend real.  Incluye factory constructors
/// (fromJson), métodos utilitarios (.map(), .where(), .toList(), .fold()).
/// ──────────────────────────────────────────────────────────────────────────────

// ─── Modelo principal: Contenido (película o serie) ─────────────────────────

/// Representa una película o serie dentro del catálogo de Tecflix Max.
class Content {
  final String id;
  final String title;
  final String overview;
  final String posterUrl;
  final String backdropUrl;
  final double rating;
  final int year;
  final String duration;
  final List<String> genres;
  final String type; // 'movie' | 'series'
  final String maturity; // 'PG-13', 'R', 'TV-MA', etc.
  final List<CastMember> cast;

  const Content({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.backdropUrl,
    required this.rating,
    required this.year,
    required this.duration,
    required this.genres,
    required this.type,
    required this.maturity,
    required this.cast,
  });

  /// Factory constructor que parsea un Map<String, dynamic>
  /// simulando una respuesta JSON de la API de catálogo.
  factory Content.fromJson(Map<String, dynamic> json) {
    // .map() + .toList() para transformar la lista de cast
    final castList = (json['cast'] as List<Map<String, dynamic>>)
        .map((c) => CastMember.fromJson(c))
        .toList();

    // .cast<String>() + .toList() para genres
    final genreList = (json['genres'] as List).cast<String>().toList();

    return Content(
      id: json['id'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String,
      posterUrl: json['posterUrl'] as String,
      backdropUrl: json['backdropUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      year: json['year'] as int,
      duration: json['duration'] as String,
      genres: genreList,
      type: json['type'] as String,
      maturity: json['maturity'] as String,
      cast: castList,
    );
  }

  /// Serializa el modelo a Map (útil para debug / logging).
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'year': year,
        'rating': rating,
        'type': type,
        'genres': genres.join(', '),
        'castCount': cast.length,
      };
}

// ─── Modelo secundario: Miembro del cast ────────────────────────────────────

class CastMember {
  final String name;
  final String role;
  final String photoUrl;

  const CastMember({
    required this.name,
    required this.role,
    required this.photoUrl,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      name: json['name'] as String,
      role: json['role'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }
}

// ─── Modelo: Categoría de contenido ─────────────────────────────────────────

/// Agrupa contenido por categoría (Tendencias, Acción, Drama, etc.)
class ContentCategory {
  final String name;
  final List<Content> items;

  const ContentCategory({required this.name, required this.items});
}

// ─── URLs de imágenes placeholder (picsum.photos) ───────────────────────────
// Usamos picsum.photos que funciona sin API key y genera imágenes variadas.

String _poster(int seed) =>
    'https://picsum.photos/seed/tecflix$seed/300/450';

String _backdrop(int seed) =>
    'https://picsum.photos/seed/back$seed/800/450';

String _photo(int seed) =>
    'https://picsum.photos/seed/actor$seed/150/150';

// ─── Fuente de datos simulada (Mock API Response) ───────────────────────────

/// Simula GET /api/catalog — respuesta JSON completa del catálogo.
final List<Map<String, dynamic>> mockCatalogResponse = [
  {
    'id': 'tt001',
    'title': 'Código Oscuro',
    'overview':
        'Un grupo de hackers descubre una conspiración global oculta en las '
        'profundidades de la dark web. Mientras intentan exponer la verdad, '
        'se convierten en los más buscados del mundo.',
    'posterUrl': _poster(1),
    'backdropUrl': _backdrop(1),
    'rating': 8.7,
    'year': 2024,
    'duration': '2h 15min',
    'genres': ['Thriller', 'Sci-Fi', 'Acción'],
    'type': 'movie',
    'maturity': 'R',
    'cast': <Map<String, dynamic>>[
      {'name': 'Carlos Méndez', 'role': 'Ethan', 'photoUrl': _photo(10)},
      {'name': 'Lucía Herrera', 'role': 'Nova', 'photoUrl': _photo(11)},
      {'name': 'Miguel Soto', 'role': 'Dr. Voss', 'photoUrl': _photo(12)},
    ],
  },
  {
    'id': 'tt002',
    'title': 'El Último Amanecer',
    'overview':
        'En un futuro donde el sol se está apagando, una científica lidera '
        'la última misión para salvar a la humanidad. Una épica carrera '
        'contra el tiempo en el espacio profundo.',
    'posterUrl': _poster(2),
    'backdropUrl': _backdrop(2),
    'rating': 9.1,
    'year': 2025,
    'duration': '2h 32min',
    'genres': ['Sci-Fi', 'Drama', 'Aventura'],
    'type': 'movie',
    'maturity': 'PG-13',
    'cast': <Map<String, dynamic>>[
      {'name': 'Ana Torres', 'role': 'Dra. Elena', 'photoUrl': _photo(13)},
      {'name': 'David Ruiz', 'role': 'Cmte. Park', 'photoUrl': _photo(14)},
      {'name': 'Rosa Delgado', 'role': 'IA ARIA', 'photoUrl': _photo(15)},
    ],
  },
  {
    'id': 'tt003',
    'title': 'Sombras de Cristal',
    'overview':
        'Una detective privada investiga la desaparición de un magnate '
        'tecnológico y descubre una red de secretos que conecta a las '
        'familias más poderosas de la ciudad.',
    'posterUrl': _poster(3),
    'backdropUrl': _backdrop(3),
    'rating': 8.3,
    'year': 2024,
    'duration': '6 Temporadas',
    'genres': ['Misterio', 'Drama', 'Crimen'],
    'type': 'series',
    'maturity': 'TV-MA',
    'cast': <Map<String, dynamic>>[
      {'name': 'Valentina Cruz', 'role': 'Det. Mara', 'photoUrl': _photo(16)},
      {'name': 'Andrés Blanco', 'role': 'Victor', 'photoUrl': _photo(17)},
      {'name': 'Carmen Vega', 'role': 'Sen. López', 'photoUrl': _photo(18)},
    ],
  },
  {
    'id': 'tt004',
    'title': 'Reinos Perdidos',
    'overview':
        'Un joven descubre que es heredero de un reino olvidado en una '
        'dimensión paralela. Deberá aprender magia ancestral para '
        'enfrentar al tirano que conquistó su mundo.',
    'posterUrl': _poster(4),
    'backdropUrl': _backdrop(4),
    'rating': 8.9,
    'year': 2025,
    'duration': '3 Temporadas',
    'genres': ['Fantasía', 'Aventura', 'Acción'],
    'type': 'series',
    'maturity': 'PG-13',
    'cast': <Map<String, dynamic>>[
      {'name': 'Diego Navarro', 'role': 'Kai', 'photoUrl': _photo(19)},
      {'name': 'Isabel Mora', 'role': 'Reina Lyra', 'photoUrl': _photo(20)},
      {'name': 'Pedro Gil', 'role': 'Thorin', 'photoUrl': _photo(21)},
    ],
  },
  {
    'id': 'tt005',
    'title': 'Frecuencia Zero',
    'overview':
        'Cuando una misteriosa señal de radio comienza a transmitir '
        'desde el fondo del océano, un equipo de oceanógrafos descubre '
        'algo que desafía toda lógica conocida.',
    'posterUrl': _poster(5),
    'backdropUrl': _backdrop(5),
    'rating': 7.8,
    'year': 2024,
    'duration': '1h 58min',
    'genres': ['Horror', 'Sci-Fi', 'Misterio'],
    'type': 'movie',
    'maturity': 'R',
    'cast': <Map<String, dynamic>>[
      {'name': 'Laura Jiménez', 'role': 'Dra. Kai', 'photoUrl': _photo(22)},
      {'name': 'Roberto Salas', 'role': 'Cap. Berg', 'photoUrl': _photo(23)},
      {'name': 'Natalia Ríos', 'role': 'Maya', 'photoUrl': _photo(24)},
    ],
  },
  {
    'id': 'tt006',
    'title': 'La Herencia',
    'overview':
        'Tres hermanos que no se hablan desde hace años deben reunirse '
        'para resolver el misterioso testamento de su padre, un famoso '
        'chef que ocultaba más que recetas.',
    'posterUrl': _poster(6),
    'backdropUrl': _backdrop(6),
    'rating': 8.5,
    'year': 2025,
    'duration': '2h 05min',
    'genres': ['Drama', 'Comedia', 'Familiar'],
    'type': 'movie',
    'maturity': 'PG-13',
    'cast': <Map<String, dynamic>>[
      {'name': 'Javier Ponce', 'role': 'Marco', 'photoUrl': _photo(25)},
      {'name': 'Sofía Luna', 'role': 'Elena', 'photoUrl': _photo(26)},
      {'name': 'Martín Arias', 'role': 'Pablo', 'photoUrl': _photo(27)},
    ],
  },
  {
    'id': 'tt007',
    'title': 'Operación Fénix',
    'overview':
        'Un agente retirado es llamado para una última misión: infiltrarse '
        'en una organización criminal que planea un ataque devastador. '
        'El reloj corre en su contra.',
    'posterUrl': _poster(7),
    'backdropUrl': _backdrop(7),
    'rating': 8.1,
    'year': 2024,
    'duration': '2h 20min',
    'genres': ['Acción', 'Thriller', 'Espionaje'],
    'type': 'movie',
    'maturity': 'R',
    'cast': <Map<String, dynamic>>[
      {'name': 'Raúl Herrera', 'role': 'Agente Cole', 'photoUrl': _photo(28)},
      {'name': 'Diana Castillo', 'role': 'Dir. Stone', 'photoUrl': _photo(29)},
      {'name': 'Emilio Fuentes', 'role': 'Viktor', 'photoUrl': _photo(30)},
    ],
  },
  {
    'id': 'tt008',
    'title': 'Ecos del Mañana',
    'overview':
        'En 2087, la humanidad puede enviar mensajes al pasado. Cuando '
        'una joven recibe un mensaje de su yo futuro, debe decidir si '
        'cambiar el curso de la historia.',
    'posterUrl': _poster(8),
    'backdropUrl': _backdrop(8),
    'rating': 9.3,
    'year': 2025,
    'duration': '4 Temporadas',
    'genres': ['Sci-Fi', 'Drama', 'Romance'],
    'type': 'series',
    'maturity': 'TV-14',
    'cast': <Map<String, dynamic>>[
      {'name': 'Camila Reyes', 'role': 'Zara', 'photoUrl': _photo(31)},
      {'name': 'Felipe Orozco', 'role': 'Dr. Lin', 'photoUrl': _photo(32)},
      {'name': 'Lorena Paz', 'role': 'Zara (2087)', 'photoUrl': _photo(33)},
    ],
  },
  {
    'id': 'tt009',
    'title': 'Calles de Fuego',
    'overview':
        'En los barrios más peligrosos de una megaciudad, un joven artista '
        'urbano usa el grafiti para denunciar la corrupción. Su arte lo '
        'convierte en símbolo de resistencia.',
    'posterUrl': _poster(9),
    'backdropUrl': _backdrop(9),
    'rating': 7.9,
    'year': 2024,
    'duration': '2 Temporadas',
    'genres': ['Drama', 'Urbano', 'Social'],
    'type': 'series',
    'maturity': 'TV-MA',
    'cast': <Map<String, dynamic>>[
      {'name': 'Óscar Vargas', 'role': 'Rayo', 'photoUrl': _photo(34)},
      {'name': 'Marcela Díaz', 'role': 'Jueza Nora', 'photoUrl': _photo(35)},
      {'name': 'Hugo Peña', 'role': 'Cuervo', 'photoUrl': _photo(36)},
    ],
  },
  {
    'id': 'tt010',
    'title': 'Guardianes del Abismo',
    'overview':
        'Un equipo de buzos de aguas profundas descubre una civilización '
        'subacuática que ha existido en secreto durante milenios. Ahora '
        'ambas civilizaciones deben coexistir.',
    'posterUrl': _poster(10),
    'backdropUrl': _backdrop(10),
    'rating': 8.6,
    'year': 2025,
    'duration': '2h 45min',
    'genres': ['Aventura', 'Sci-Fi', 'Fantasía'],
    'type': 'movie',
    'maturity': 'PG-13',
    'cast': <Map<String, dynamic>>[
      {'name': 'Renata Solís', 'role': 'Cap. Reed', 'photoUrl': _photo(37)},
      {'name': 'Tomás Aguilar', 'role': 'Rey Nereus', 'photoUrl': _photo(38)},
      {'name': 'Clara Mendoza', 'role': 'Dra. Voss', 'photoUrl': _photo(39)},
    ],
  },
];

// ─── Utilidades de datos (demuestran .map, .where, .fold, .toList) ──────────

/// Parsea la respuesta mock y retorna una List<Content> tipada.
/// Demuestra .map() + .toList() sobre datos dinámicos.
List<Content> parseAllContent(List<Map<String, dynamic>> raw) {
  return raw.map((json) => Content.fromJson(json)).toList();
}

/// Filtra contenido por tipo ('movie' o 'series').
/// Demuestra .where() + .toList().
List<Content> filterByType(List<Content> all, String type) {
  return all.where((c) => c.type == type).toList();
}

/// Filtra por género específico.
/// Demuestra .where() con .contains() sobre una List interna.
List<Content> filterByGenre(List<Content> all, String genre) {
  return all.where((c) => c.genres.contains(genre)).toList();
}

/// Obtiene los títulos mejor valorados (rating >= minRating).
/// Demuestra .where() encadenado con .toList() y condición numérica.
List<Content> getTopRated(List<Content> all, {double minRating = 8.5}) {
  return all.where((c) => c.rating >= minRating).toList();
}

/// Calcula el rating promedio del catálogo.
/// Demuestra .fold() como acumulador.
double averageRating(List<Content> all) {
  if (all.isEmpty) return 0;
  final total = all.fold<double>(0, (sum, c) => sum + c.rating);
  return total / all.length;
}

/// Genera las categorías del home organizando el contenido.
/// Demuestra múltiples operaciones de Listas y Mapas combinadas.
List<ContentCategory> buildCategories(List<Content> all) {
  return [
    ContentCategory(
      name: '🔥 Tendencias Ahora',
      items: getTopRated(all, minRating: 8.0),
    ),
    ContentCategory(
      name: '🎬 Películas',
      items: filterByType(all, 'movie'),
    ),
    ContentCategory(
      name: '📺 Series',
      items: filterByType(all, 'series'),
    ),
    ContentCategory(
      name: '⚡ Acción y Aventura',
      items: filterByGenre(all, 'Acción')
        ..addAll(filterByGenre(all, 'Aventura')
            .where((c) => !filterByGenre(all, 'Acción').contains(c))),
    ),
    ContentCategory(
      name: '🧪 Sci-Fi',
      items: filterByGenre(all, 'Sci-Fi'),
    ),
    ContentCategory(
      name: '🎭 Drama',
      items: filterByGenre(all, 'Drama'),
    ),
  ];
}
