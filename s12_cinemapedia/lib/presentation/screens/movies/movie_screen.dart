import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';
import 'package:s12_cinemapedia/presentation/providers/movies/movie_info_provider.dart';

import '../../providers/actors.dart/actor_info_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = "movie-screen";

  final String movieId;

  const MovieScreen({
    Key? key, 
    required this.movieId
  }) : super(key: key);

  @override
  ConsumerState createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();

    ref.read( movieInfoProvider.notifier ).loadMovie( widget.movieId );
    ref.read( actotInfoProvider.notifier ).loadActors( widget.movieId );
  }

  @override
  Widget build(BuildContext context) {

    final movie = ref.watch( movieInfoProvider )[widget.movieId];
    if( movie == null ) return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2,),));
 
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomAppBar(movie: movie,),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1
          ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10,),

              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( movie.title, style: style.titleLarge,),
                    Text( movie.overview,)
                  ],
                ),
              )

            ],
          ),
        ),

        // genres
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((e) => Container(
                margin: const EdgeInsets.only( right: 10),
                child: Chip(
                  label: Text(e),
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8)),
                ),
              )).toList()
            ],
          ),
        ),

        // actors
        _ActorByMovie(id: movie.id.toString(),),

         const SizedBox(height: 100,),
      ],
    );
  }
}

class _ActorByMovie extends ConsumerWidget {

  final String id;
  const _ActorByMovie({required this.id});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch( actotInfoProvider );
    if( data[id] == null) return const CircularProgressIndicator( strokeWidth: 2,);

    final actors = data[id]!;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(8),
            width: 125,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    actor.profilePath,
                    height: 100,
                    width: 135,
                    fit: BoxFit.cover,
                  ),
                ),
                //name
                const SizedBox( height: 5,),

                Text(actor.name, maxLines: 2,),
                Text(actor.character, maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          );
      },),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: MediaQuery.of(context).size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(movie.title, style: const TextStyle(fontSize: 20), textAlign: TextAlign.start,),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network( movie.posterPath, fit: BoxFit.cover, ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black87
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0]
                  )
                )
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    stops: [0.4, 1.0]
                  )
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}