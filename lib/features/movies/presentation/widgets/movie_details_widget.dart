import 'dart:async';

import 'dart:ui' as ui;
import 'package:clean_arch/features/movies/presentation/widgets/movie_genre_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/img_assets.dart';
import '../../../../core/assets/svg_assets.dart';
import '../../domain/entities/movie.dart';
import '../view_models/movie_details_view_model.dart';
import 'error_dialog_widget.dart';


class MovieDetailsWidget extends StatefulWidget {
  MovieDetailsWidget({@required this.movie, @required this.viewModel, this.callback});
  Movie movie;
  final MovieDetailsViewModel viewModel;
  final Function(Movie) callback;


  @override
  State<StatefulWidget> createState() {
    return _MovieDetailsWidgetState();
  }
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  ErrorDialogWidget errorWidget;
  @override
  void initState()
  {
    super.initState();
    errorWidget=ErrorDialogWidget();

  }



  @override
  Widget build(BuildContext context) {
    bool _isImageLoaded = false;
    var placeholderImage =
        Image.asset(ImgAssets.no_image_png, fit: BoxFit.cover);
    Image image;
    Completer<ui.Image> completer;

    try {
      image = Image.network(
        widget.movie.poster,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace stackTrace) {
          return Image.asset(ImgAssets.no_image_png, fit: BoxFit.cover);
        },
      );

      completer = new Completer<ui.Image>();
      image.image
          .resolve(new ImageConfiguration())
          .addListener(ImageStreamListener((ImageInfo info, bool _) {
        if (mounted) {
          setState(() {
            _isImageLoaded = true;
          });
          completer.complete(info.image);
        }
      }));
    } on Exception catch (error) {

      _isImageLoaded = false;
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new FutureBuilder<ui.Image>(
              future: completer.future,
              builder:
                  (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                if (!snapshot.hasData) {
                  return new Text('Image not available.',
                      style: Theme.of(context).textTheme.bodyMedium);
                } else {
                  return SizedBox();
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _isImageLoaded
                    ? image
                    : SizedBox(
                        width: 100,
                        height: 100,
                        child: placeholderImage,
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Movie title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Movie title

                        Flexible(
                            child: Text(
                          widget.movie.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),

                        SizedBox(
                            width: 40,
                            height: 40,
                            child: GestureDetector(
                              onTap: () {
                                widget.callback(widget.viewModel.movie);
                                widget.viewModel.update();
                              },
                              child: widget.movie.isFavorite == false
                                  ?

                                  /// Favorite icon
                                  SvgPicture.asset(
                                      SvgAssets.favorite_icon_border,
                                      semanticsLabel: 'favorite border',
                                      color: Colors.black54,
                                    )
                                  : SvgPicture.asset(
                                      SvgAssets.favorite_icon_filled,
                                      semanticsLabel: 'favorite filled',
                                      color: Colors.redAccent,
                                    ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    /// Genre
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MovieGenreWidget(
                            genre: widget.viewModel.movieDetails.genre),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    ///Release date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Release date

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: 'Release date:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    .apply(
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        " ${widget.viewModel.movieDetails.releaseDate}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ]),
                          ),
                        ),

                        /// Run time

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: 'Run time:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    .apply(
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        " ${widget.viewModel.movieDetails.runTime}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    /// Director
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Director

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: 'Director:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    .apply(
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        " ${widget.viewModel.movieDetails.director}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    /// Actors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Actors

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: 'Actors:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    .apply(
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        " ${widget.viewModel.movieDetails.actors}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    /// Plot
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Plot

                        Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 100,
                            child: SingleChildScrollView(
                              child: RichText(
                                text: TextSpan(
                                    text: 'Plot:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        .apply(
                                            fontStyle: FontStyle.italic,
                                            decoration:
                                                TextDecoration.underline),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            " ${widget.viewModel.movieDetails.plot}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      )
                                    ]),
                              ),
                            )),
                      ],
                    ),

                    /// Imdb rating
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        /// Imdb rating

                        Flexible(
                          child: RichText(
                            text: TextSpan(
                                text: 'IMDB Rating:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    .apply(
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        " ${widget.viewModel.movieDetails.imdbRating}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
