import 'package:pokedex_bloc/core/error/failure.dart';
import 'package:pokedex_bloc/core/utils/either.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/data/pokemon_local_data.dart';

class FavoritePokemonRepository {
  final IPokemonLocalData pokemonLocalData;

  FavoritePokemonRepository(this.pokemonLocalData);

  Stream<Either<Failure, List<Pokemon>>> getAllPokemon() async* {
    yield* runSGuard(() => pokemonLocalData.getAllPokemon());
  }

  Stream<Either<Failure, List<Pokemon>>> searchPokemon() async* {
    yield* runSGuard(() => pokemonLocalData.getAllPokemon());
  }

  Future<Either<Failure, void>> savePokemon(Pokemon pokemon) =>
      runGuard(() async {
        await pokemonLocalData.savePokemon(pokemon);
        return;
      });

  Future<Either<Failure, void>> deletePokemon(int id) => runGuard(() async {
        await pokemonLocalData.deletePokemon(id);
        return;
      });
}
