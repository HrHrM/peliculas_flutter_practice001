import 'package:componentes/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  const MovieHorizontal({Key? key, required this.peliculas}) : super(key: key);
  final List<Pelicula> peliculas;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: _screenSize.height * 0.2,
      child: PageView(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.1,
        ),
        children: _tarjetas(context),
      ),
    );
  }

  List<Widget> _tarjetas(context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: const EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: const AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            Text(
              pelicula.title ?? '',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
