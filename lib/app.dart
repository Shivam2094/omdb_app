import 'package:clean_arch/core/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/utils/routes/routes_navigator.dart';
import 'core/utils/routes/routes_name.dart';
import 'features/movies/presentation/view_models/movie_list_view_model.dart';
import 'features/movies/presentation/views/movies_list_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieListViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: UiHelper.appTheme(),
        initialRoute: RoutesName.movie_list_screen,
        onGenerateRoute: RoutesNavigator.generateRoute,
      ),
    );



    //
    //   MaterialApp(
    //   title: 'OMDB Movies',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //     home:
    //     ChangeNotifierProvider(
    //       create: (_) => MovieListViewModel(),
    //       child: MoviesListScreen(),
    //     )
    //   // home: const UniversitiesScreenManualSubscription(),
    // );
  }
}