# 🎬 Tecflix Max — Guía Práctica & Plantilla Avanzada de Flutter

¡Bienvenido a **Tecflix Max**! Esta es una aplicación móvil premium inspirada en plataformas de streaming líderes como Netflix y HBO Max. El proyecto ha sido diseñado desde cero no solo como una interfaz visualmente espectacular, sino como una **plantilla de referencia arquitectónica y guía práctica** para dominar conceptos avanzados de desarrollo con Flutter.

El repositorio oficial de este proyecto se encuentra en:  
🔗 **[https://github.com/Hazielcode/tecflix-max-la10-flutter](https://github.com/Hazielcode/tecflix-max-la10-flutter)**

---

## 🚀 Conceptos Clave Demostrados

Este proyecto sirve como material de estudio y código de producción de referencia para 6 pilares fundamentales de Flutter:

### 1. ListViews Eficientes y de Alto Rendimiento
En lugar de cargar todos los elementos en memoria a la vez, Tecflix Max implementa:
*   **`ListView.builder` vertical y horizontal:** Usado para construir dinámicamente las filas de categorías y carruseles de películas. Solo renderiza en pantalla los elementos que son visibles para el usuario, logrando una tasa constante de 60fps/120fps.
*   **Scroll con física fluida:** Se implementó `BouncingScrollPhysics()` para proporcionar un efecto de rebote elástico premium característico de iOS en todas las plataformas.

### 2. Widgets y Componentes Personalizados
*   **`ContentCard`:** Tarjeta de poster tipo cartelera con detección táctil optimizada, micro-animación de escala (`AnimatedScale`) al mantener presionado, sombras volumétricas y badges dinámicos para ratings y tipo de contenido.
*   **`CastMemberCard`:** Tarjeta circular estilizada para representar a los actores y sus roles respectivos de forma limpia.

### 3. Manipulación Avanzada de Colecciones (Listas y Mapas)
El modelo de datos simula una respuesta JSON real y utiliza programación funcional para el procesamiento de colecciones en la capa de datos:
*   **`.map()` & `.toList()`:** Para transformar listas de mapas JSON en objetos fuertemente tipados.
*   **`.where()`:** Filtra en tiempo real el catálogo para separar películas (`movie`) de series (`series`) o por géneros específicos.
*   **`.any()`:** Utilizado en el motor de recomendaciones para buscar contenido similar que comparta al menos un género en común.
*   **`.fold()`:** Usado para calcular de forma acumulativa y eficiente métricas globales como el rating promedio del catálogo.

### 4. Rutas Nombradas y Paso de Parámetros Tipados
Navegación limpia y centralizada:
*   **Rutas declaradas globalmente:** Configuradas en el `MaterialApp` (`/` para Home, `/details` para Detalles).
*   **Paso de argumentos tipados:** Envío de objetos `Content` completos a través de `Navigator.pushNamed(context, '/details', arguments: content)`.
*   **Recepción elegante:** Extraídos en la vista de destino de forma segura usando `ModalRoute.of(context)!.settings.arguments as Content`.

### 5. Tema Global e Implícito (Material 3 & Dark Mode)
*   **Dark Mode Nativo:** Diseñado bajo estándares de streaming con colores base oscuros profundos (`#0A0A0F`), evitando fatiga visual y resaltando las imágenes de las carteleras.
*   **Compatibilidad Multi-Versión:** Optimizado para la versión local de Flutter **3.24.5** sustituyendo APIs experimentales por constructores estables como `ThemeMode.system` para sincronización con el sistema operativo.

### 6. Sistema de 3 Fuentes Tipográficas Diferenciadas
Configurado en `main.dart` utilizando `GoogleFonts` para asegurar consistencia visual y jerarquía en la interfaz:
1.  **Poppins (Títulos):** Una fuente geométrica y elegante con alta legibilidad, ideal para headers principales, nombres de secciones y títulos de películas.
2.  **Inter (Cuerpo y Texto General):** Altamente optimizada para pantallas pequeñas, utilizada en sinopsis, descripciones de actores y metadatos del sistema.
3.  **Fira Code (Monospace - Bloques Técnicos):** Utilizada en el apartado de depuración de datos JSON para simular bloques de código con ligaduras legibles de programación.

---

## 🛠️ Arquitectura del Proyecto

El código está estructurado siguiendo principios de separación de responsabilidades (*Separation of Concerns*):

```text
lib/
│
├── main.dart                 # Inicialización, configuración del Tema Global y Rutas.
│
├── models/
│   └── data_model.dart       # Modelos fuertemente tipados (Content, CastMember) y lógica de colecciones.
│
├── views/
│   ├── home_view.dart        # Catálogo principal, Hero Banner y carruseles horizontales.
│   └── details_view.dart     # Vista detallada de películas, Reparto, JSON visualizer y Recomendados.
│
└── widgets/
    ├── category_row.dart     # Carrusel horizontal con ListView.builder.
    └── content_card.dart     # Tarjetas táctiles individuales con micro-animaciones.
```

---

## ⚙️ Instrucciones de Ejecución e Instalación

### Requisitos Previos
*   Flutter SDK instalado (Compatible con Flutter 3.24.5+).
*   Dart SDK 3.5.4+.

### Instalación
1.  Clona este repositorio en tu máquina local:
    ```bash
    git clone https://github.com/Hazielcode/tecflix-max-la10-flutter.git
    cd proyectoflutter
    ```
2.  Descarga las dependencias del proyecto:
    ```bash
    flutter pub get
    ```
3.  Ejecuta la aplicación en modo Debug en tu dispositivo o navegador de preferencia (Chrome/Edge):
    ```bash
    flutter run -d chrome
    ```

---

## 📸 Capturas de Pantalla (Showcase)

*¡Inserta aquí tus mejores capturas de pantalla del emulador o navegador para lucir tu diseño premium!*

| 🏠 Pantalla Principal (Catálogo) | 🎬 Vista de Detalle (Película/Serie) |
|:---:|:---:|
| <!-- Agrega tu captura de Home aquí --> | <!-- Agrega tu captura de Detalle aquí --> |
| ![Home Screenshot](https://raw.githubusercontent.com/Hazielcode/tecflix-max-la10-flutter/main/web/favicon.png) | ![Details Screenshot](https://raw.githubusercontent.com/Hazielcode/tecflix-max-la10-flutter/main/web/favicon.png) |

---

## 🛠️ Tecnologías Utilizadas
*   [Flutter](https://flutter.dev) - UI Software Development Kit.
*   [Google Fonts](https://pub.dev/packages/google_fonts) - Tipografías del sistema de diseño de Google.

---

Desarrollado con ❤️ por **[Hazielcode](https://github.com/Hazielcode)** como parte de la entrega de laboratorios prácticos avanzados de desarrollo móvil.
