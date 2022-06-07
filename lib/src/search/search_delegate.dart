import 'package:componentes/src/models/movie_model.dart';
import 'package:componentes/src/providers/peliculas_providers.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  String? seleccion = '';
  final peliculasProvider = PeliculasProvider();

  final peliculas = [
    'Houseki no kuni',
    'Hai to Gensou no Grimgar',
    'Sonny Boy',
    'Yuru Camp',
    'Watamote',
    'Kaede Akamatsu'
  ];

  final peliculasRecientes = ['Houseki no Kuni', 'Kaede Akamatsu'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print('Clicked actions');
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          print('Clicked leading');
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion!),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias cuando el usuario escribe
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas?.map(
                  (pelicula) {
                    return ListTile(
                      leading: FadeInImage(
                        image: NetworkImage(pelicula.getPosterImg()),
                        placeholder:
                            const AssetImage('assets/imgs/no-image.jpg'),
                        width: 50.0,
                        fit: BoxFit.contain,
                      ),
                      title: Text('${pelicula.title}'),
                      subtitle: Text('${pelicula.originalTitle}'),
                      onTap: () {
                        Navigator.pop(context);
                        pelicula.uniqueId = '';
                        Navigator.pushNamed(context, 'detalle',
                            arguments: pelicula);
                      },
                    );
                  },
                ).toList() ??
                [],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    // final listaSugerida = (query.isEmpty)
    //     ? peliculasRecientes
    //     : peliculas
    //         .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
    //         .toList();

    // return ListView.builder(
    //   itemCount: listaSugerida.length,
    //   itemBuilder: (context, i) {
    //     return ListTile(
    //       leading: const Icon(Icons.movie),
    //       title: Text(
    //         listaSugerida[i],
    //       ),
    //       onTap: () {
    //         seleccion = listaSugerida[i];
    //         showResults(context);
    //       },
    //     );
    //   },
    // );
  }
}
