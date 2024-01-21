import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/config/constants.dart';
import 'package:pokedex_bloc/config/theme.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/persentation/bloc/favorite_pokemon_cubit.dart';
import 'package:pokedex_bloc/persentation/bloc/state.dart';
import 'package:pokedex_bloc/persentation/pokemon/all_pokemon.dart';
import 'package:pokedex_bloc/persentation/pokemon/favorite_pokemon.dart';

class AppPokemon extends StatefulWidget {
  const AppPokemon({Key? key}) : super(key: key);

  @override
  State<AppPokemon> createState() => _AppPokemonState();
}

class _AppPokemonState extends State<AppPokemon> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "POKEDEX",
            style: TextStyle(color: AppColors.textPrimaryColor),
          ),
        ),
        body: const Column(
          children: [
            _TabBarHeader(),
            Expanded(
              child: TabBarView(
                children: [
                  AllPokemon(),
                  FavouritePokemon(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarHeader extends StatelessWidget {
  const _TabBarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: ColoredBox(
        color: Colors.white,
        child: TabBar(
          unselectedLabelColor: const Color(0xff6B6B6B),
          labelColor: const Color(0xff161A33),
          indicatorColor: AppColors.primaryColor,
          labelPadding: const EdgeInsets.symmetric(vertical: Insets.xs),
          indicatorWeight: 3,
          tabs: [
            const Tab(
              child: Text(
                'All Pokemons',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            Tab(
              child:
                  BlocBuilder<FavoritePokemonCubit, BlocState<List<Pokemon>>>(
                builder: (context, state) {
                  final count = state.data.length;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Favourites',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      if (count != 0) ...[
                        const SizedBox(width: Insets.xs),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          padding: const EdgeInsets.all(Insets.xs),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ]
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
