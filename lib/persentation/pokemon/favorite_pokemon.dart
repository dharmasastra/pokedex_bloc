import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/config/constants.dart';
import 'package:pokedex_bloc/config/theme.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/persentation/bloc/favorite_pokemon_cubit.dart';
import 'package:pokedex_bloc/persentation/bloc/search_pokemon_cubit.dart';
import 'package:pokedex_bloc/persentation/bloc/state.dart';
import 'package:pokedex_bloc/persentation/pokemon/widget/pokemon_grid.dart';

class FavouritePokemon extends StatefulWidget {
  const FavouritePokemon({Key? key}) : super(key: key);

  @override
  State<FavouritePokemon> createState() => _FavouritePokemonState();
}

class _FavouritePokemonState extends State<FavouritePokemon> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return isSearch
        ? BlocBuilder<SearchPokemonCubit, BlocState<List<Pokemon>>>(
            builder: (context, state) {
              final pokemons = state.data;
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(Insets.sm),
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        color: AppColors.scaffoldColor,
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      onChanged: (query) {
                        context.read<SearchPokemonCubit>().searchPokemon(
                              query,
                            );
                      },
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: AppColors.textBodyColor,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GridView.builder(
                      key: const PageStorageKey('favourite_pokemon_tab'),
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(Insets.sm),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: maxGridExtent,
                        mainAxisSpacing: Insets.sm,
                        crossAxisSpacing: Insets.sm,
                      ),
                      itemCount: pokemons.length,
                      itemBuilder: (context, index) => PokemonGrid(
                        pokemon: pokemons[index],
                      ),
                    ),
                  )
                ],
              );
            },
          )
        : BlocBuilder<FavoritePokemonCubit, BlocState<List<Pokemon>>>(
            builder: (context, state) {
              final pokemons = state.data;
              if (pokemons.isNotEmpty) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(Insets.sm),
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                          color: AppColors.scaffoldColor,
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        onTap: () {
                          setState(() {
                            isSearch = true;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: AppColors.textBodyColor,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        key: const PageStorageKey('favourite_pokemon_tab'),
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(Insets.sm),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: maxGridExtent,
                          mainAxisSpacing: Insets.sm,
                          crossAxisSpacing: Insets.sm,
                        ),
                        itemCount: pokemons.length,
                        itemBuilder: (context, index) => PokemonGrid(
                          pokemon: pokemons[index],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "Your favourite pokemons would show here.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                );
              }
            },
          );
  }
}
