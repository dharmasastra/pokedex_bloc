import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/persentation/bloc/favorite_pokemon_cubit.dart';

class FloatingButton extends StatelessWidget {
  final bool isPokemonMarkedAsFavourite;
  final Pokemon pokemon;
  const FloatingButton(
    this.pokemon, {
    this.isPokemonMarkedAsFavourite = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (isPokemonMarkedAsFavourite) {
            context.read<FavoritePokemonCubit>().removePokemon(pokemon.id);
          } else {
            context.read<FavoritePokemonCubit>().addPokemon(pokemon);
          }
        },
        child: isPokemonMarkedAsFavourite
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 50,
              )
            : const Icon(
                Icons.favorite_border,
                color: Colors.red,
                size: 50,
              ));
  }
}
