import 'package:find_your_home_test/di/di.dart';
import 'package:find_your_home_test/modules/home/presentation/bloc/home/home_bloc.dart';
import 'package:find_your_home_test/modules/home/presentation/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  final String? email;
  final String? name;
  const HomePage({super.key, this.email, this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  onHouseTap( String id ){
    context.push('/house/$id', extra: {
      'email': widget.email,
    });
    //Navegar hasta la housepage y mostrar detalles de la casa pasando el id de la casa
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeBloc>()..add(const HomeLoadRequested()),
      child: Scaffold(
        body: HomeView(email: widget.email, name: widget.name, onHouseTap: onHouseTap),
      ),
    );
  }
}