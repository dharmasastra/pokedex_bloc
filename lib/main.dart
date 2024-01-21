import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_bloc/config/constants.dart';
import 'package:pokedex_bloc/core/app.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/data/pokemon_api_data.dart';
import 'package:pokedex_bloc/data/pokemon_local_data.dart';
import 'package:pokedex_bloc/repository/favorite_pokemon_repository.dart';
import 'package:pokedex_bloc/repository/pokemon_repository.dart';
import 'package:pokedex_bloc/repository/search_pokemon_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PokemonAdapter());
  Hive.registerAdapter(PokemonNameAndUrlAdapter());
  Hive.registerAdapter(PokemonTypeAdapter());

  final favoriteDb = await Hive.openBox<Pokemon>(LocalDbKeys.favoriteDb);

  final pokemonRepository = PokemonRepository(
    PokemonApiData(),
  );

  final favoritePokemonRepository = FavoritePokemonRepository(
    PokemonLocalData(favoriteDb),
  );

  final searchPokemonRepository = SearchPokemonRepository(
    PokemonLocalData(favoriteDb),
  );

  runApp(
    App(
      pokemonRepository: pokemonRepository,
      favoritePokemonRepository: favoritePokemonRepository,
      searchPokemonRepository: searchPokemonRepository,
    ),
  );
}
