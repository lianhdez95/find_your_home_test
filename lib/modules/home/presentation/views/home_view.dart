import 'package:find_your_home_test/core/theme/theme_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_your_home_test/modules/home/presentation/bloc/home/home_bloc.dart';
import 'package:find_your_home_test/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  final String? email;
  final String? name;
  const HomeView({super.key, this.email, this.name});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final titleText = 'Find Your Home';

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          pinned: true,
          expandedHeight: 160,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 16),
            title: Text(titleText, style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary)),
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
                  padding: const EdgeInsets.only(left: 16, bottom: 80, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: context.colorScheme.onPrimary.withAlpha(40),
                        child: Icon(Icons.person, size: 32, color: context.colorScheme.onPrimary),
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${l10n!.welcomeMessage}, $name',
                            style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onPrimary),
                          ),
                          if (email != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              email!,
                              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary.withAlpha(220)),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Explora propiedades', style: context.titleLarge),
               
              ],
            ),
          ),
        ),
        // Contenido dinámico desde el Bloc
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.loading || state.status == HomeStatus.initial) {
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
                          onPressed: () => context.read<HomeBloc>().add(const HomeLoadRequested()),
                          child: const Text('Reintentar'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            final items = state.houses;
            if (items.isEmpty) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: Text('No hay propiedades disponibles.')),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  final h = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((h.image ?? '').isNotEmpty)
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: CachedNetworkImage(
                                imageUrl: h.image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: context.colorScheme.surfaceVariant,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/load-35.gif',
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: context.colorScheme.surfaceVariant,
                                  child: const Center(child: Icon(Icons.home_outlined, size: 48)),
                                ),
                              ),
                            ),
                          ListTile(
                            leading: CircleAvatar(backgroundColor: context.primaryBlue.withAlpha(40), child: Icon(Icons.home_outlined, color: context.primaryBlue)),
                            title: Text(h.title ?? 'Propiedad'),
                            subtitle: Text(h.city ?? ''),
                              trailing: Text(
                                h.price != null ? '${h.price!.toStringAsFixed(0)} €' : '',
                                style: context.titleMedium.copyWith(color: context.primaryBlue, fontWeight: FontWeight.w600),
                              ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: items.length,
              ),
            );
          },
        ),
        // Espacio final
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}