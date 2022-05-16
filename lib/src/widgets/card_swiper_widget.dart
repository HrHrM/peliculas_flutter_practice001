import 'package:componentes/src/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> movies;

  CardSwiper({required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movies[index].getPosterImg()),
                placeholder: const AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ));
        },
        itemWidth: _screenSize.width * 0.4,
        itemHeight: _screenSize.height * 0.5,
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
    ;
  }
}
