import 'package:pokedex_bloc/core/error/failure.dart';
import 'package:pokedex_bloc/core/utils/either.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/data/pokemon_api_data.dart';

class PokemonRepository {
  final IPokemonApiData pokemonApiData;

  PokemonRepository(this.pokemonApiData);

  Future<Either<Failure, List<Pokemon>>> getAllPokemon(int offset) =>
      runGuard(() async {
        final pokemonList = await pokemonApiData.getAllPokemon(offset);
        return pokemonList;
      });

  Future<Either<Failure, Pokemon>> getPokemonById(int id) => runGuard(() async {
        final pokemon = await pokemonApiData.getPokemonById(id);
        return pokemon;
      });
}
