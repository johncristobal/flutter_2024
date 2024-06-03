import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';

import '../../../config/helpers/human_format.dart';

class MovieHorizontalList extends StatefulWidget {

  final List<Movie> movies;
  final String? label;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalList({Key? key, 
  required this.movies, 
  this.label, 
  this.subtitle, 
  this.loadNextPage}) : super(key: key);

  @override
  State<MovieHorizontalList> createState() => _MovieHorizontalListState();
}

class _MovieHorizontalListState extends State<MovieHorizontalList> {

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if(widget.loadNextPage == null) return;
      if ( (controller.position.pixels + 200)  >= controller.position.maxScrollExtent ) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          (widget.label != null || widget.subtitle != null) 
          ? _Title(label: widget.label!, sutitle: widget.subtitle!,)
          : Container(),

          Expanded(
            child: ListView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index],));
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final styles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //* Image
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) {
                    return const Center(child: CircularProgressIndicator(),);
                  }

                  return GestureDetector(
                    onTap: (){
                      context.push("/movie/${movie.id}");
                    },
                    child: FadeIn(child: child)
                  );
                },
              )
            )
          ),

          const SizedBox(height: 5,),

          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: styles.titleSmall,
            ),
          ),

          Row(
            children: [
              Icon(Icons.star_half, color: Colors.yellow.shade500),
              const SizedBox(width: 3,),
              Text("${movie.voteAverage}", style: styles.bodyMedium!.copyWith(color: Colors.yellow.shade300),),
              const SizedBox(width: 8,),
              Text(HumanFormats.number(movie.popularity), style: styles.bodySmall,)
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String label, sutitle;
  const _Title({Key? key, required this.label, required this.sutitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final style = Theme.of(context).textTheme.labelLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric( horizontal: 10),
      child: Row(
        children: [
          Text(label, style: style,),
          const Spacer(),
          FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            onPressed: (){},
            child: Text(sutitle),
          )
        ],
      ),
    );
  }
}