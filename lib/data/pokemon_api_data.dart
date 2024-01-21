import 'package:dio/dio.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';

abstract class IPokemonApiData {
  Future<List<Pokemon>> getAllPokemon(int offset);
  Future<Pokemon> getPokemonById(int id);
}

const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';
const int limit = 20;

class PokemonApiData implements IPokemonApiData {
  Dio dio = Dio();
  @override
  Future<List<Pokemon>> getAllPokemon(int offset) async {
    final endpoint = '$baseUrl?offset=$offset&limit=$limit';
    final response = await dio.get(endpoint);
    final pokemonList = (response.data['results'] as List).map((pokemon) {
      List<String> urlPaths = (pokemon['url'] as String).split('/');
      final PokemonId = urlPaths[urlPaths.length - 2];
      return Pokemon.fromMap(pokemon).copyWith(
        id: int.parse(PokemonId),
      );
    }).toList();
    return pokemonList;
  }

  @override
  Future<Pokemon> getPokemonById(int id) async {
    final response = await dio.get('$baseUrl/$id');
    return Pokemon.fromMap(response.data);
  }
}
