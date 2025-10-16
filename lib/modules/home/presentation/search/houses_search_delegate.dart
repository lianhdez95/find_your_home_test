import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_your_home_test/core/theme/theme_extensions.dart';
import 'package:find_your_home_test/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:find_your_home_test/core/network/network_info.dart';
import 'package:find_your_home_test/modules/home/domain/entities/house_preview.dart';
import 'package:find_your_home_test/modules/home/domain/repositories/houses_repository.dart';
import 'package:go_router/go_router.dart';

class HousesSearchDelegate extends SearchDelegate<void> {
  HousesSearchDelegate({
    required HousesRepository repository,
    required NetworkInfo networkInfo,
    this.userEmail,
    required String searchHint,
  }) : _repository = repository,
       _networkInfo = networkInfo,
       super(searchFieldLabel: searchHint);

  final HousesRepository _repository;
  final NetworkInfo _networkInfo;
  final String? userEmail;

  final StreamController<List<HousePreview>> _controller =
      StreamController.broadcast();
  final StreamController<bool> _loadingCtrl = StreamController.broadcast();
  Timer? _debounce;
  String _lastQuery = '';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            _controller.add(const []);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  void _scheduleSearch(String q) {
    _debounce?.cancel();
    if (q.trim().isEmpty) {
      _controller.add(const []);
      _loadingCtrl.add(false);
      return;
    }
    _loadingCtrl.add(true);
    _debounce = Timer(const Duration(seconds: 2), () async {
      final connected = await _networkInfo.isConnected;
      final result = await _repository.getHouses(forceRefresh: connected);
      result.fold(
        onErr: (_) {
          _controller.add(const []);
          _loadingCtrl.add(false);
        },
        onOk: (list) {
          final qq = q.toLowerCase();
          final filtered = list.where((h) {
            final t = (h.title ?? '').toLowerCase();
            final c = (h.city ?? '').toLowerCase();
            return t.contains(qq) || c.contains(qq);
          }).toList();
          _controller.add(filtered);
          _loadingCtrl.add(false);
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (query != _lastQuery) {
      _lastQuery = query;
      _scheduleSearch(query);
    }

    return StreamBuilder<bool>(
      stream: _loadingCtrl.stream,
      initialData: false,
      builder: (context, loadingSnap) {
        final isLoading = loadingSnap.data ?? false;
        return StreamBuilder<List<HousePreview>>(
          stream: _controller.stream,
          initialData: const [],
          builder: (context, snapshot) {
            final data = snapshot.data ?? const [];
            if (query.isEmpty) {
              return Center(child: Text(l10n!.find_center));
            }
            if (isLoading) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Image.asset('assets/images/load-35.gif', height: 60),
                    const SizedBox(height: 12),
                    Text(l10n!.searching, style: context.bodyLarge),
                  ],
                ),
              );
            }
            if (data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      size: 64,
                      color: context.errorColor,
                    ),
                    const SizedBox(height: 12),
                    Text(l10n!.no_results, style: context.bodyLarge),
                  ],
                ),
              );
            }
            return ListView.separated(
              itemCount: data.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final h = data[index];
                return ListTile(
                  leading: (h.image ?? '').isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            imageUrl: h.image!,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const CircleAvatar(child: Icon(Icons.home_outlined)),
                  title: Text(h.title ?? 'Propiedad'),
                  subtitle: Text(h.city ?? ''),
                  trailing: Text(
                    h.price != null ? '${h.price!.toStringAsFixed(0)} €' : '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    final id = h.id ?? '';
                    if (id.isEmpty) return;
                    context.push('/house/$id', extra: {'email': userEmail});
                    close(context, null);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Reusamos las sugerencias como resultados
    return buildSuggestions(context);
  }

  @override
  void close(BuildContext context, void result) {
    _debounce?.cancel();
    _controller.close();
    _loadingCtrl.close();
    super.close(context, result);
  }
}
