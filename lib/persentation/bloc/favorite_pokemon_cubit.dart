import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/persentation/bloc/state.dart';
import 'package:pokedex_bloc/repository/favorite_pokemon_repository.dart';

class FavoritePokemonCubit extends Cubit<BlocState<List<Pokemon>>> {
  final FavoritePokemonRepository pokemonRepository;

  FavoritePokemonCubit({required this.pokemonRepository})
      : super(BlocState.initial(const []));


  void getFavoritePokemons() async {
    emit(state.copyWith(status: PageStatus.loading));
    pokemonRepository.getAllPokemon().listen((failureOrPokemons) {
      failureOrPokemons.fold(
          (failure) => emit(
              state.copyWith(status: PageStatus.error, error: failure.message)),
          (pokemons) =>
              emit(state.copyWith(status: PageStatus.ready, data: pokemons)));
    });
  }

  void addPokemon(Pokemon pokemon) async {
    final failureOreSuccess = await pokemonRepository.savePokemon(pokemon);
    if (failureOreSuccess.isLeft()) {
      emit(state.copyWith(
        status: PageStatus.error,
        error: failureOreSuccess.getLeft().message,
      ));
    }
  }

  void removePokemon(int id) async {
    final failureOreSuccess = await pokemonRepository.deletePokemon(id);
    if (failureOreSuccess.isLeft()) {
      emit(state.copyWith(
        status: PageStatus.error,
        error: failureOreSuccess.getLeft().message,
      ));
    }
  }
}
