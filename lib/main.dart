import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constant/styles.dart';
import 'injection.dart';
import 'presentation/bloc/search/search_bloc.dart';
import 'presentation/bloc/search_mode/search_mode_bloc.dart';
import 'presentation/bloc/view_mode/view_mode_bloc.dart';
import 'presentation/home_page.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (context) => getIt<SearchBloc>()..add(GetCachedData()),
        ),
        BlocProvider<SearchModeBloc>(
          create: (context) =>
              getIt<SearchModeBloc>()..add(GetLastSearchMode()),
        ),
        BlocProvider<ViewModeBloc>(
          create: (context) => getIt<ViewModeBloc>()..add(GetLastViewMode()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        home: const HomePage(),
      ),
    );
  }
}
