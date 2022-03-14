import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_project/screens/news_feed_screen.dart';

import 'logic/filter_bloc/filter_bloc.dart';
import 'logic/internet/connectioncheck_cubit.dart';
import 'logic/internet/internet_cubit.dart';
import 'logic/news_bloc/news_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My News',
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NewsBloc>(
            create: (context) => NewsBloc(),
          ),
          BlocProvider<FilterBloc>(
            create: (context) => FilterBloc(),
          ),
          BlocProvider<ConnectionCheckerCubit>(
            create: (_) => ConnectionCheckerCubit(
                internetConnectionChecker: InternetConnectionChecker()),
          ),
          BlocProvider<InternetCubit>(
            create: (_) => InternetCubit(connectivity: Connectivity()),
          ),
        ],
        child: const NewsFeedScreen(),
      ),
    );
  }
}
