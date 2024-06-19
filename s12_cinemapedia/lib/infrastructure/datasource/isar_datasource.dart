import 'package:isar/isar.dart';
import 'package:s12_cinemapedia/domain/datasources/local_datasource.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalDatasource {

  late Future<Isar> db;

  IsarDatasource() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    if(Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [ MovieSchema ],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
   final isar = await db;
   final Movie? movie = await isar.movies
   .filter()
   .idEqualTo(movieId)
   .findFirst();

   return movie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return await isar.movies
    .where()
    .offset(offset)
    .limit(limit)
    .findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final favMovie = await isar.movies
    .filter()
    .idEqualTo(movie.id)
    .findFirst();

    if(favMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favMovie.isarId!));
      return;
    } else {
      isar.writeTxnSync(() => isar.movies.putSync(movie));
    }
  }
}
