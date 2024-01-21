import 'dart:async';
import 'package:hive/hive.dart';
import 'package:pokedex_bloc/core/error/error.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';

abstract class IPokemonLocalData {
  Stream<List<Pokemon>> getAllPokemon();
  Future<void> savePokemon(Pokemon pokemon);
  Future<void> deletePokemon(int id);
}

class PokemonLocalData implements IPokemonLocalData {
  final Box<Pokemon> boxPokemon;
  PokemonLocalData(this.boxPokemon) : assert(boxPokemon.isOpen);

  @override
  Stream<List<Pokemon>> getAllPokemon() async* {
    try {
      yield boxPokemon.values.toList();
      await for (final _ in boxPokemon.watch()) {
        yield boxPokemon.values.toList();
      }
    } catch (e) {
      throw CacheGetException("$e");
    }
  }

  @override
  Future<void> savePokemon(Pokemon pokemon) async {
    try {
      unawaited(boxPokemon.put(pokemon.id, pokemon));
    } catch (e) {
      throw CachePutException("$e");
    }
  }

  @override
  Future<void> deletePokemon(int id) async {
    try {
      unawaited(boxPokemon.delete(id));
    } catch (e) {
      throw CachePutException("$e");
    }
  }
}
