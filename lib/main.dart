import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_block/block/create_post_cubit.dart';
import 'package:pattern_block/block/list_post_cubit.dart';
import 'package:pattern_block/block/update_post_cubit.dart';
import 'package:pattern_block/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> ListPostCubit()),
          BlocProvider(create: (context)=> CreatePostCubit()),
          BlocProvider(create: (context)=> UpdatePostCubit()),
        ], child: HomePage(),
      ),
    );
  }
}

