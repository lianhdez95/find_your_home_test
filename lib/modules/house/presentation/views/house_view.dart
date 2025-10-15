import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_your_home_test/core/theme/theme_extensions.dart';
import 'package:find_your_home_test/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_your_home_test/modules/house/presentation/bloc/house_detail_bloc.dart';
import 'package:find_your_home_test/shared/widgets/animated_favorite_button.dart';

class HouseView extends StatelessWidget {
  const HouseView({super.key});

  @override
  Widget build(BuildContext context) {
    
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);


    return BlocBuilder<HouseDetailBloc, HouseDetailState>(
      builder: (context, state) {
        if (state.status == HouseDetailStatus.loading || state.status == HouseDetailStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == HouseDetailStatus.failure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.error_outline, size: 40),
                SizedBox(height: 8),
                Text('No se pudo cargar el detalle'),
              ],
            ),
          );
        }
        final d = state.detail!;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 220,
                foregroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    d.title ?? 'Propiedad',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                background: (d.image ?? '').isNotEmpty
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: d.image!,
                              fit: BoxFit.cover,
                            ),
                            // Degradado negro en la parte inferior para legibilidad del título
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withAlpha(200),
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 0.55],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(color: theme.colorScheme.surface),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: AnimatedFavoriteButton(
                    isFavorite: state.isFavorite,
                    size: 40,
                    activeColor: Colors.redAccent,
                    inactiveColor: Colors.white,
                    enableShadows: true,
                    onTap: () {
                      context.read<HouseDetailBloc>().add(const HouseDetailFavoriteToggled(userEmail: null));
                    },
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: theme.colorScheme.primary),
                        const SizedBox(width: 6),
                        Expanded(child: Text(d.city ?? '')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      d.price != null ? '${d.price!.toStringAsFixed(0)} €' : '',
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if ((d.description ?? '').isNotEmpty) ...[
                      Text(l10n!.description, style: context.headlineMedium),
                      const SizedBox(height: 8),
                      Text(d.description!, style: context.titleLarge.copyWith(fontWeight: FontWeight.normal)),
                      const SizedBox(height: 16),
                    ],
                    Text(l10n!.address, style: context.headlineMedium),
                    const SizedBox(height: 8),
                    Text('${d.address ?? ''} ${d.houseNumber ?? ''}', style: context.titleLarge.copyWith(fontWeight: FontWeight.normal)),
                    Text(d.zipCode ?? '', style: context.titleLarge.copyWith(fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}