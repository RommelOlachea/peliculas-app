import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar peliculas';
  @override
  List<Widget>? buildActions(BuildContext context) {
    // Creamos un boton para limpiar el campo de busqueda
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Regremos a la pantalla anterior, en close, ponemos lo que queremos regresar,
    //puede ser cualquier tipo de dato, en este caso null
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // cuerpo de la busqueda, donde mostramos los resultados
    if (query.isEmpty) {
      return Container(
        child: Center(
            child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 130,
        )),
      );
    }

    return Container();
  }
}
