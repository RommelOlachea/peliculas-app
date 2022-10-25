import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Cambiar luego por una instancia de movie
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
        body: CustomScrollView(
      slivers: [_CustomAppBar()],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200, //es el height inicial
      floating: false,
      pinned:
          true, //para que no desaparesca por completo aunque se mueva hacia arriba regresa
      flexibleSpace: FlexibleSpaceBar(
        //acomoda el texto y tamaño de acuerdo se mueva la barra con el scroll
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),

        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: const Text(
            'Movie.title',
            style: TextStyle(fontSize: 16),
          ),
        ),

        background: const FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage('https://via.placeholder.com/500x300'),
            fit: BoxFit.cover),
      ),
    );
  }
}
