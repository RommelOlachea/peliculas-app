import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

import '../models/models.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments! as Movie;
    print(movie.title);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(
          movie: movie,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTtile(movie: movie),
          _Overview(movie: movie),
          CastingCard(
            movieId: movie.id,
          )
        ])),
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({super.key, required this.movie});

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
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),

        background: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(movie.fullBackdropPath),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _PosterAndTtile extends StatelessWidget {
  final Movie movie;

  const _PosterAndTtile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline,
                      size: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${movie.voteAverage}',
                      style: textTheme.caption,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
