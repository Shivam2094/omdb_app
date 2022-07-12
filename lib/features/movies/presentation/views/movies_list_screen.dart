import 'package:clean_arch/core/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/response/status.dart';

import '../view_models/movie_list_view_model.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/movie_list_widget.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({Key key}) : super(key: key);

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  MovieListViewModel viewModel;
  ErrorDialogWidget errorWidget;

  @override
  void initState() {
    super.initState();

    viewModel = MovieListViewModel();
    viewModel.fetchAllMovies();
    errorWidget = ErrorDialogWidget();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text(
          'Movie List',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<MovieListViewModel>(
          create: (BuildContext context) => viewModel,
          child: Consumer<MovieListViewModel>(builder: (context, viewModel, _) {
            switch (viewModel.movieListResponse.status) {
              case ResponseState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    color: UiHelper.BLUE_COLOR,
                  ),
                );
                break;
              case ResponseState.ERROR:
                return errorWidget.showDialog(context,"Server Exception ",
                    viewModel.movieListResponse.message,
                    "Retry",(movie) => viewModel.fetchAllMovies());

                break;
              case ResponseState.COMPLETED:
                return MovieListWidget(
                  movies: viewModel.movies,
                  viewModel: viewModel,
                );
                break;
            }
            return Container();
          }),
        ),
      ),
    );
  }
}
