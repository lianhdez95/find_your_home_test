# Find Your Home — Documentación del Proyecto

Aplicación Flutter para explorar propiedades inmobiliarias con enfoque en rendimiento, experiencia de usuario y soporte offline-first. Incluye autenticación local, listado con favoritos, búsqueda con debounce e integración a detalle de propiedad.

## ✨ Características principales

- Autenticación local (registro/login) con persistencia en SharedPreferences y hash SHA-256.
- Listado de propiedades con cache local y estrategia online-first con fallback offline.
- Favoritos por usuario con persistencia local y animación + haptics al marcar.
- Búsqueda con SearchDelegate y debounce de 2s (online cuando hay red, local cuando no).
- Detalle de propiedad con botón de favoritos fijo al final (Filled/Outlined según estado).
- Theming Material 3, soporte de i18n (gen-l10n + ARB) y enrutamiento con go_router.
- Manejo de errores unificado (Result/Failure) y mapeo de DioException.

## 🧱 Arquitectura y patrones

Basado en Clean Architecture:

- domain: entidades y casos de uso.
- data: datasources (remote/local) y repositories impl.
- presentation: BLoC + vistas/páginas/widgets.

Patrones y librerías:

- Estado: flutter_bloc + Equatable.
- DI: get_it.
- Networking: Dio con interceptors.
- Conectividad: connectivity_plus (NetworkInfo).
- Cache y preferencias: SharedPreferences.
- Imágenes: cached_network_image.
- Navegación: go_router.
- Env: flutter_dotenv (BASE_URL).

## 🗂️ Estructura de carpetas (resumen)

- `lib/`
	- `core/` utilidades comunes: router, theme, network, error, i18n.
	- `modules/`
		- `auth/` login/registro.
		- `home/` listado, búsqueda, favoritos.
		- `house/` detalle de propiedad.
	- `shared/` widgets reutilizables (por ejemplo `animated_favorite_button.dart`).

Ejemplos de archivos clave:

- `core/network/dio_client.dart`: cliente HTTP con interceptors y helpers.
- `core/error/failure.dart` y `core/error/dio_failure_mapper.dart`.
- `core/network/network_info.dart`: online/offline.
- `modules/home/...`: listado, cache local, favoritos, búsqueda.
- `modules/house/...`: detalle de propiedad.
- `core/router/app_router.dart`: rutas (incluye `/house/:id`).

## 🔐 Autenticación y persistencia

- Usuarios almacenados en SharedPreferences (correo + hash SHA-256).
- Email del usuario se usa como clave para favoritos por usuario.
- Favoritos: `Set<String>` con IDs de casas por usuario.

## 🔍 Búsqueda con debounce y modo offline

- SearchDelegate con 2s de debounce para evitar spam de red.
- Si hay red: obtiene remoto y filtra por título/ciudad; se cachea resultado.
- Si no hay red: filtra sobre cache local.
- Muestra estado de “Buscando…” durante el debounce.

## 🏠 Detalle de propiedad

- Carga por `/houses/:id` desde el repositorio.
- UI con SliverAppBar, gradiente inferior para legibilidad de textos y botón de favoritos en la parte inferior.
- Toggle optimista de favoritos con rollback si falla.

## 🌐 Offline-first

- Estrategia online-first: cuando hay conectividad, se trae del servidor y se actualiza cache; si no, se usa cache.
- NetworkInfo (connectivity_plus) decide la fuente.

## 🧩 Buenas prácticas aplicadas

- Clean Architecture con separación estricta por capas.
- Result/Failure para errores tipados y mapeo de Dio a Failures.
- Inyección de dependencias con get_it.
- Reutilización de UI y componentes (AnimatedFavoriteButton, etc.).
- Material 3, theming centralizado y soporte de i18n.
- Debounce y loaders claros durante tareas de red.
- Prácticas de UX: animaciones, haptics al marcar favorito, legibilidad sobre imágenes.

## ⚙️ Requisitos previos

- Flutter estable (3.22+ recomendado) y Dart acorde.
- macOS con Xcode si compilas iOS; Android Studio/SDK para Android.
- Node no requerido.

## 🚀 Configuración y ejecución

1. Instalar dependencias

```zsh
flutter pub get
```

1. Variables de entorno

- Se usa `flutter_dotenv` para `BASE_URL`.
- Crea un archivo `.env` en la raíz con:

```env
BASE_URL=https://tu-api.com
```

1. Ejecutar la app

```zsh
# iOS (simulador)
flutter run -d ios

# Android (emulador o dispositivo)
flutter run -d android

# Web (opcional)
flutter run -d chrome
```

Notas iOS:

```zsh
cd ios && pod install && cd ..
```

## 🧪 Tests

- Tests de widgets y de lógica (BLoC / use cases) pueden ejecutarse con:

```zsh
flutter test
```

## 🧭 Rutas principales

- `/` Login
- `/home` Listado principal
- `/house/:id` Detalle de propiedad

## 🧰 Scripts útiles (opcional)

```zsh
# Generar localizaciones (si usas gen-l10n)
flutter gen-l10n

# Formatear
dart format .

# Aplicar fixes automáticos
dart fix --apply
```

## 📐 Estándares de código

- Linter activado en `analysis_options.yaml`.
- Preferir `Equatable` para estados/eventos de BLoC.
- Evitar lógica en UI; delegar en casos de uso/BLoC.
- Manejo de errores via `Result<Ok, Failure>`.
- Nombres consistentes por capa (DataSource/Repository/UseCase).

## 🐞 Troubleshooting

- “No carga datos en offline”: asegúrate de haber abierto la app con red al menos una vez para poblar cache.
- “BASE_URL no definida”: crea `.env` en raíz y reinicia la app.
- iOS fallando en pods: ejecuta `pod repo update && pod install` dentro de `ios/`.
- Errores de análisis por APIs deprecadas: ejecutar `dart fix --apply` y revisar notas en código.

## 📈 Roadmap / Próximos pasos

- Persistir preferencia “Ver solo favoritos” entre sesiones.
- Localizar textos pendientes (botones, estados vacíos).
- Tests de integración para flujo completo (login → listado → detalle → favoritos).
- Métricas/telemetría opcional (Firebase Analytics).
- Mejoras de accesibilidad (textScaler vs textScaleFactor, contrastes).

## 📎 Licencia

Proyecto con fines demostrativos/educativos.

