import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/persentation/bloc/state.dart';
import 'package:pokedex_bloc/repository/pokemon_repository.dart';

class PokemonCubit extends Cubit<BlocState<List<Pokemon>>> {
  final PokemonRepository pokemonRepository;

  PokemonCubit({required this.pokemonRepository})
      : super(BlocState.initial(const []));

  int _offset = 0;

  void getPokemons({PageStatus bootstrapStatus = PageStatus.loading}) async {
    emit(state.copyWith(status: bootstrapStatus));
    final failureOrPokemons = await pokemonRepository.getAllPokemon(_offset);
    failureOrPokemons.fold(
        (failure) => emit(
            state.copyWith(status: PageStatus.error, error: failure.message)),
        (pokemons) => emit(state.copyWith(
            status: PageStatus.ready,
            data: state.data.followedBy(pokemons).toList())));
  }

  void getMorePokemons() async {
    if (!state.isLoading) {
      _offset += 20;
      getPokemons(bootstrapStatus: PageStatus.loadingMore);
    }
  }

  void getPokemonById(int id) async {
    emit(state.copyWith(status: PageStatus.loading));
    final failureOrPokemon = await pokemonRepository.getPokemonById(id);
    failureOrPokemon.fold(
        (failure) => emit(
            state.copyWith(status: PageStatus.error, error: failure.message)),
        (pokemon) => emit(state.copyWith(
              status: PageStatus.ready,
              data: state.data
                  .map((e) => e.id == pokemon.id ? pokemon : e)
                  .toList(),
            )));
  }
}
