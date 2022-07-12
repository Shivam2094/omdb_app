import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_arch/core/assets/img_assets.dart';
import 'package:clean_arch/core/assets/svg_assets.dart';
import 'package:clean_arch/core/utils/routes/routes_navigator.dart';
import 'package:clean_arch/features/movies/domain/entities/movie.dart';
import 'package:clean_arch/features/movies/presentation/ui_utils/movie_type_color.dart';
import 'package:clean_arch/core/utils/string_extension.dart';
import 'package:clean_arch/features/movies/presentation/view_models/movie_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/routes/routes_name.dart';

class MovieCardWidget extends StatefulWidget {
  MovieCardWidget(
      {@required this.movie, this.width, this.height, this.cardMargin, this.callback, this.listViewModel});
  
  final Movie movie;
  final width;
  final height;
  final EdgeInsets cardMargin;
  final Function(Movie) callback;
  final MovieListViewModel listViewModel;


  @override
  State<StatefulWidget> createState() {
    return _MovieCardWidgetState();
  }
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: widget.cardMargin ?? EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
      child: GestureDetector(
        onTap: (){
          RoutesNavigator.movie=widget.movie;
          RoutesNavigator.listViewModel=widget.listViewModel;
          Navigator.pushNamed(context, RoutesName.movie_details_screen);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Color(0xff000000),
              ),

            ),

          ),
          width: widget.width?? MediaQuery.of(context).size.width,
          height: widget.height??150,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Thumbnail image
                AspectRatio(
                aspectRatio: 0.8,
                  child: Container(
                    child:CachedNetworkImage(
                      imageUrl: widget.movie.poster,
                      placeholder: (context, url) => Image.asset(ImgAssets.no_image_png),
                      errorWidget: (context, url, error) => Image.asset(
                                ImgAssets.no_image_png,
                                fit: BoxFit.cover),
                    ),


                  ),
                ),
                AspectRatio(
                  aspectRatio: 2,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// Movie title

                              Flexible(child: Text(widget.movie.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),))
                            ],
                          ),
                         /// Release year
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Text(widget.movie.year,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16
                                ),)
                            ],
                          ),

                          /// Movie type
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Text(widget.movie.type.capitalize(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    color: MovieTypeColor.colorMap[widget.movie.type]
                                  ))
                            ],
                          ),
                          //SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: GestureDetector(
                                  onTap: (){


                                    widget.callback(widget.movie);

                                  },
                                  child:widget.movie.isFavorite==false?
                                  SvgPicture.asset(
                                      SvgAssets.favorite_icon_border,
                                      semanticsLabel: 'favorite border',
                                    color: Colors.black54,
                                  ):SvgPicture.asset(
                                    SvgAssets.favorite_icon_filled,
                                    semanticsLabel: 'favorite filled',
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),


                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],

            ),
          ),

        ),
      ),
    );
  }
}