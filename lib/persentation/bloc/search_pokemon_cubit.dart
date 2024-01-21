import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/persentation/bloc/state.dart';
import 'package:pokedex_bloc/repository/search_pokemon_repository.dart';

class SearchPokemonCubit extends Cubit<BlocState<List<Pokemon>>> {
  final SearchPokemonRepository searchPokemonRepository;

  SearchPokemonCubit({required this.searchPokemonRepository})
      : super(BlocState.initial(const []));

  void searchPokemon(String query) {
    emit(state.copyWith(status: PageStatus.loading));
    searchPokemonRepository.searchPokemon().listen((failureOrPokemons) {
      failureOrPokemons.fold(
        (failure) => emit(
            state.copyWith(status: PageStatus.error, error: failure.message)),
        (pokemons) => query.isEmpty
            ? emit(state.copyWith(
                status: PageStatus.ready,
                data: pokemons,
              ))
            : emit(state.copyWith(
                status: PageStatus.ready,
                data: pokemons
                    .where((pokemon) => pokemon.name.contains(query))
                    .toList(),
              )),
      );
    });
  }
}
