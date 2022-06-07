import 'package:componentes/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  MovieHorizontal(
      {Key? key, required this.peliculas, required this.siguientePagina})
      : super(key: key);

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        // print('Cargar siguientes peliculas');
        siguientePagina();
      }
    });

    return SizedBox(
      height: _screenSize.height * 0.27,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-posterdsggsdgdsg';

    final tarjeta = Container(
      margin: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId ?? 'No hay tag de peli en tarjeta',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: const AssetImage('assets/imgs/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
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

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        print('Pelicula popular ${pelicula.title}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  // List<Widget> _tarjetas(context) {
  //   return peliculas.map((pelicula) {
  //     return Container(
  //       margin: const EdgeInsets.only(right: 15.0),
  //       child: Column(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20.0),
  //             child: FadeInImage(
  //               placeholder: const AssetImage('assets/imgs/no-image.jpg'),
  //               image: NetworkImage(pelicula.getPosterImg()),
  //               fit: BoxFit.cover,
  //               height: 160.0,
  //             ),
  //           ),
  //           Text(
  //             pelicula.title ?? '',
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}
