import 'package:componentes/src/models/movie_model.dart';
import 'package:componentes/src/providers/movie_horizontal.dart';
import 'package:componentes/src/providers/peliculas_providers.dart';
import 'package:componentes/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Phos'),
        backgroundColor: Colors.greenAccent[400],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            movies: snapshot.data ?? [],
          );
        } else {
          return const SizedBox(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }

  Widget _footer(BuildContext conext) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text('Populares', style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: 5.0),
          FutureBuilder(
            future: peliculasProvider.getPopulares(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data ?? [],
                );
              } else {
                return const SizedBox(
                  height: 400.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
