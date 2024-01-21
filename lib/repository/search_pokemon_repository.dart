import 'package:pokedex_bloc/core/error/failure.dart';
import 'package:pokedex_bloc/core/utils/either.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/data/pokemon_local_data.dart';

class SearchPokemonRepository {
  final IPokemonLocalData pokemonLocalData;

  SearchPokemonRepository(this.pokemonLocalData);

  Stream<Either<Failure, List<Pokemon>>> searchPokemon() async* {
    yield* runSGuard(() => pokemonLocalData.getAllPokemon());
  }
}
