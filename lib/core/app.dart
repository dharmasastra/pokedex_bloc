import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/config/constants.dart';
import 'package:pokedex_bloc/config/theme.dart';
import 'package:pokedex_bloc/persentation/app_pokemon.dart';
import 'package:pokedex_bloc/persentation/bloc/favorite_pokemon_cubit.dart';
import 'package:pokedex_bloc/persentation/bloc/pokemon_cubit.dart';
import 'package:pokedex_bloc/persentation/bloc/search_pokemon_cubit.dart';
import 'package:pokedex_bloc/repository/favorite_pokemon_repository.dart';
import 'package:pokedex_bloc/repository/pokemon_repository.dart';
import 'package:pokedex_bloc/repository/search_pokemon_repository.dart';

class App extends StatelessWidget {
  final PokemonRepository pokemonRepository;
  final FavoritePokemonRepository favoritePokemonRepository;
  final SearchPokemonRepository searchPokemonRepository;

  const App({
    super.key,
    required this.pokemonRepository,
    required this.favoritePokemonRepository,
    required this.searchPokemonRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonCubit>(
          create: (context) => PokemonCubit(
            pokemonRepository: pokemonRepository,
          )..getPokemons(),
        ),
        BlocProvider<FavoritePokemonCubit>(
          create: (context) => FavoritePokemonCubit(
            pokemonRepository: favoritePokemonRepository,
          )..getFavoritePokemons(),
        ),
        BlocProvider<SearchPokemonCubit>(
          create: (context) => SearchPokemonCubit(
            searchPokemonRepository: searchPokemonRepository,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: lightThemeData,
        home: const AppPokemon(),
      ),
    );
  }
}
