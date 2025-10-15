import 'package:find_your_home_test/di/di.dart';
import 'package:find_your_home_test/modules/house/presentation/views/house_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_your_home_test/modules/house/presentation/bloc/house_detail_bloc.dart';

class HousePage extends StatefulWidget {
  final String houseId;
  final String? userEmail;
  const HousePage({super.key, required this.houseId, this.userEmail});

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HouseDetailBloc>()
        ..add(HouseDetailLoadRequested(houseId: widget.houseId, userEmail: widget.userEmail)),
      child: const Scaffold(
        body: HouseView(),
      ),
    );
  }
}