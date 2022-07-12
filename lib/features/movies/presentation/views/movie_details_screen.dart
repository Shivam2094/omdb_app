

import 'package:clean_arch/features/movies/presentation/view_models/movie_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/assets/svg_assets.dart';
import '../../../../core/response/status.dart';

import '../../../../core/utils/ui_helper.dart';
import '../../domain/entities/movie.dart';
import '../view_models/movie_details_view_model.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/movie_details_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  final MovieListViewModel listViewModel;

  const MovieDetailsScreen({Key key, @required this.movie, this.listViewModel,}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsViewModel viewModel;
  ErrorDialogWidget errorWidget;



  @override
  void initState() {
    super.initState();

    viewModel= MovieDetailsViewModel(movie: widget.movie);
    viewModel.fetchMovieDetails();
    errorWidget=ErrorDialogWidget();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: Theme.of(context).
        appBarTheme.iconTheme,

        title: Text('Movie Detail',
          style: Theme.of(context).
          appBarTheme.titleTextStyle,),
        leadingWidth: UiHelper.APP_BAR_ICON_SIZE,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: GestureDetector(
            onTap: (){
              widget.listViewModel.cacheMovieList();
              Navigator.pop(context);



            },
            child: SizedBox(
              width: UiHelper.APP_BAR_ICON_SIZE,
              height: UiHelper.APP_BAR_ICON_SIZE,
              child: SvgPicture.asset(

                SvgAssets.chevron_left,

                semanticsLabel: 'left-chevron',
                color: UiHelper.WHITE_COLOR,


              ),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                onTap: () {
                  _shareMovieDetails(context);
                },
                child: SizedBox(
                  width: UiHelper.APP_BAR_ICON_SIZE,
                  height: UiHelper.APP_BAR_ICON_SIZE,
                  child: SvgPicture.asset(

                    SvgAssets.share_icon,

                    semanticsLabel: 'share-icon',
                    color: UiHelper.WHITE_COLOR,


                  ),
                ),
              )
          ),

        ],


      ),
      body: SafeArea(
        child: ChangeNotifierProvider<MovieDetailsViewModel>(
          create: (BuildContext context) => viewModel,
          child: Consumer<MovieDetailsViewModel>(builder: (context, viewModel, _) {
            switch (viewModel.movieDetailsResponse.status) {
              case ResponseState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    color: UiHelper.BLUE_COLOR,
                  ),
                );
                break;
              case ResponseState.ERROR:
                return errorWidget.showDialog(context,"Server Exception ",
                    viewModel.movieDetailsResponse.message,
                    "Retry",(movieDetails) => viewModel.fetchMovieDetails());

                break;
              case ResponseState.COMPLETED:
                return MovieDetailsWidget(movie: viewModel.movie,viewModel: viewModel,
                       callback:(movie)=>widget.listViewModel.setMovieAsFavorite(viewModel.movie));
                break;
            }
            return Container();
          }),
        ),
      ),
    );
  }

  void _shareMovieDetails(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox;
    await Share.share(
        widget.movie.title,
        subject: widget.movie.poster,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

}