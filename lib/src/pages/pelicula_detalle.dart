import 'package:componentes/src/models/actores_model.dart';
import 'package:componentes/src/models/movie_model.dart';
import 'package:componentes/src/providers/peliculas_providers.dart';
import 'package:flutter/material.dart';

class PeliculaDetalle extends StatelessWidget {
  const PeliculaDetalle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pelicula? pelicula =
        ModalRoute.of(context)?.settings.arguments as Pelicula?;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula!),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 10.0),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text(
          '${pelicula.title}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/imgs/loading.gif'),
          image: NetworkImage(pelicula.getBackgroundImg()),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 150),
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      child: Row(
        children: <Widget>[
          const SizedBox(width: 20.0),
          Hero(
            tag: pelicula.uniqueId ?? 'uniqueId',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(
                  pelicula.getPosterImg(),
                ),
                height: 150.0,
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${pelicula.title}',
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${pelicula.originalTitle}',
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_border),
                    Text(
                      '${pelicula.voteAverage}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        '${pelicula.overview}',
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(
        pelicula.id.toString(),
      ),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor>? actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actores?.length,
        itemBuilder: (BuildContext context, int i) =>
            _actorTarjeta(actores![i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: const AssetImage('assets/imgs/no-image.jpg'),
              image: NetworkImage(actor.getPhoto()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            '${actor.name}',
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
