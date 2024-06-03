
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/domain/entities/actor.dart';
import 'actor_repo_provider.dart';

final actotInfoProvider = StateNotifierProvider<ActorMapNotifier, Map<String, List<Actor>>>((ref) {
  final fetch = ref.watch( actorRepoProvider );
  return ActorMapNotifier(getActors: fetch.getActorsByMovie );
});

typedef GetActorsCallback = Future<List<Actor>>Function(String id);

class ActorMapNotifier extends StateNotifier<Map<String, List<Actor>>> {

  final GetActorsCallback getActors;
  ActorMapNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String id) async {
    if( state[id] != null ) return;
    final actors = await getActors( id );    
    state = {...state, id: actors };
  }
}