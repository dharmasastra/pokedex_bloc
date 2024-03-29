import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/config/constants.dart';
import 'package:pokedex_bloc/config/theme.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/persentation/bloc/pokemon_cubit.dart';
import 'package:pokedex_bloc/persentation/bloc/state.dart';
import 'package:pokedex_bloc/persentation/pokemon/widget/pokemon_grid.dart';

class AllPokemon extends StatefulWidget {
  const AllPokemon({Key? key}) : super(key: key);

  @override
  State<AllPokemon> createState() => _AllPokemonState();
}

class _AllPokemonState extends State<AllPokemon> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() => paginate());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void paginate() {
    if ((scrollController.position.pixels >=
        scrollController.position.maxScrollExtent + 100)) {
      context.read<PokemonCubit>().getMorePokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCubit, BlocState<List<Pokemon>>>(
      builder: (context, state) {
        final pokemons = state.data;

        if (pokemons.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  key: const PageStorageKey('all_pokemon_tab'),
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(Insets.sm),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              if (state.isLoadingMore)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        }

        if (state.isError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.getError(),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () => context.read<PokemonCubit>().getPokemons(),
                  child: const Text(
                    'RETRY',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
