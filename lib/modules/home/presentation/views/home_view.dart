import 'package:find_your_home_test/core/theme/theme_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_your_home_test/modules/home/presentation/bloc/home/home_bloc.dart';
import 'package:find_your_home_test/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_your_home_test/shared/widgets/animated_favorite_button.dart';
import 'package:find_your_home_test/di/di.dart';
import 'package:find_your_home_test/core/network/network_info.dart';
import 'package:find_your_home_test/modules/home/domain/repositories/houses_repository.dart';
import 'package:find_your_home_test/modules/home/presentation/search/houses_search_delegate.dart';

class HomeView extends StatelessWidget {
  final String? email;
  final String? name;
  final void Function(String id) onHouseTap;
  const HomeView({super.key, this.email, this.name, required this.onHouseTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final titleText = 'Find Your Home';
    final double height = MediaQuery.of(context).size.height;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double appBarCollapsedHeight =
        kToolbarHeight + topPadding; // altura del appbar fijo

    // Al primer build, si tenemos email del usuario, disparamos carga de favoritos
    if (email != null) {
      // No bloquear el build; encolamos el evento
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.read<HomeBloc>().add(HomeFavoritesLoadRequested(email!));
        }
      });
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(const HomeRefreshRequested());
      },
      edgeOffset: appBarCollapsedHeight,
      displacement:
          120, // distancia visual desde el borde superior del contenido
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: 160,
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16,
                end: 8,
                bottom: 5,
              ),
              title: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      titleText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    icon: Icon(
                      Icons.search,
                      color: theme.colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      final repo = locator<HousesRepository>();
                      final net = locator<NetworkInfo>();
                      final hint =
                          l10n?.find_header ?? 'Buscar por nombre o ciudad';
                      showSearch(
                        context: context,
                        delegate: HousesSearchDelegate(
                          repository: repo,
                          networkInfo: net,
                          userEmail: email,
                          searchHint: hint,
                        ),
                      );
                    },
                  ),
                ],
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.primaryBlue,
                      context.primaryBlue.withAlpha(180),
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      bottom: 80,
                      right: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: context.colorScheme.onPrimary
                              .withAlpha(40),
                          child: Icon(
                            Icons.person,
                            size: 32,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${l10n!.welcomeMessage}, $name',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            if (email != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                email!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onPrimary.withAlpha(
                                    220,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Un bloque inicial con saludo/información
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Explora propiedades', style: context.titleLarge),
                  BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (p, n) =>
                        p.showOnlyFavorites != n.showOnlyFavorites,
                    builder: (context, state) {
                      final active = state.showOnlyFavorites;
                      void onPressed() {
                        context.read<HomeBloc>().add(
                          const HomeFilterFavoritesToggled(),
                        );
                      }
                      return active
                          ? FilledButton.icon(
                              onPressed: onPressed,
                              style: FilledButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                minimumSize: const Size(0, 36),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.favorite, size: 18),
                              label: const Text('Ver todos'),
                            )
                          : OutlinedButton.icon(
                              onPressed: onPressed,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: theme.colorScheme.primary,
                                minimumSize: const Size(0, 36),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.favorite_border, size: 18),
                              label: const Text('Ver favoritos'),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Contenido dinámico desde el Bloc
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatus.loading ||
                  state.status == HomeStatus.initial) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }
              if (state.status == HomeStatus.failure) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.error_outline, size: 40),
                          const SizedBox(height: 8),
                          Text('No se pudieron cargar las propiedades.'),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => context.read<HomeBloc>().add(
                              const HomeLoadRequested(),
                            ),
                            child: const Text('Reintentar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              // Aplica filtro "solo favoritos" si está activo
              List items = state.houses;
              if (state.showOnlyFavorites) {
                final favs = state.favorites;
                items = items
                    .where((h) => h.id != null && favs.contains(h.id))
                    .toList();
              }
              if (items.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text('No hay propiedades disponibles.'),
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((ctx, index) {
                  final h = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((h.image ?? '').isNotEmpty)
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Stack(
                                children: [
                                  Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: h.image!,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                              color:
                                                  context.colorScheme.surface,
                                              child: Center(
                                                child: Image.asset(
                                                  'assets/images/load-35.gif',
                                                  width: 48,
                                                  height: 48,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              color:
                                                  context.colorScheme.surface,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.home_outlined,
                                                  size: 48,
                                                ),
                                              ),
                                            ),
                                      ),
                                      IgnorePointer(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            gradient: RadialGradient(
                                              center: Alignment.topRight,
                                              radius: 0.9,
                                              colors: [
                                                Color.fromRGBO(0, 0, 0, 0.6),
                                                Color.fromRGBO(0, 0, 0, 0.0),
                                              ],
                                              stops: [0.0, 1.0],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  BlocBuilder<HomeBloc, HomeState>(
                                    buildWhen: (p, n) =>
                                        p.favorites != n.favorites,
                                    builder: (context, state) {
                                      final isFav = state.favorites.contains(
                                        h.id,
                                      );
                                      return Positioned(
                                        right: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: AnimatedFavoriteButton(
                                            isFavorite: isFav,
                                            size: height * 0.04,
                                            activeColor: Colors.redAccent,
                                            inactiveColor: Colors.white,
                                            onTap: email == null
                                                ? null
                                                : () => context
                                                      .read<HomeBloc>()
                                                      .add(
                                                        HomeFavoriteToggled(
                                                          userEmail: email!,
                                                          houseId: h.id ?? '',
                                                        ),
                                                      ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: context.primaryBlue.withAlpha(
                                40,
                              ),
                              child: Icon(
                                Icons.home_outlined,
                                color: context.primaryBlue,
                              ),
                            ),
                            title: Text(h.title ?? 'Propiedad'),
                            subtitle: Text(h.city ?? ''),
                            trailing: Text(
                              h.price != null
                                  ? '${h.price!.toStringAsFixed(0)} €'
                                  : '',
                              style: context.titleMedium.copyWith(
                                color: context.primaryBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () => onHouseTap(h.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: items.length),
              );
            },
          ),
          // Espacio final
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
