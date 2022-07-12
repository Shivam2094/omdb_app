import 'package:flutter/material.dart';

import '../../../../core/utils/ui_helper.dart';


class MovieGenreWidget extends StatelessWidget{
  final String genre;

  MovieGenreWidget({@required this.genre});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: UiHelper.BROWN_COLOR,
        ),
        borderRadius: BorderRadius.circular(10),
        color: UiHelper.ORANGE_COLOR,
      ),
      child: Center(child:
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Text("$genre",
            style: Theme.of(context).textTheme.bodyMedium,),
        ),
      )),
    );
  }
}