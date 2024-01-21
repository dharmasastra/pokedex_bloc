
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 0)
class Pokemon extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(3)
  final num weight;

  @HiveField(4)
  final num height;

  @HiveField(5)
  final List<PokemonType> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.types,
  });

  bool get hasAdditionalInfo => weight != 0 && height != 0;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

  String get pokedexId => "#${id.toString().padLeft(3, '0')}";

  String get baseType {
    return types.isNotEmpty ? types[0].type.name : "";
  }

  double get bmi {
    if (height == 0 || weight == 0) return 0;
    return (weight / (height * height));
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'] ?? 0,
      weight: map['weight'] ?? 0,
      height: map['height'] ?? 0,
      name: map['name'] ?? "",
      types: map['types'] != null
          ? (map['types'] as List)
              .map((type) => PokemonType.fromMap(type))
              .toList()
          : [],
    );
  }

@override
  List<Object> get props {
    return [
      id,
      name,
      weight,
      height,
      types,
    ];
  }

  Pokemon copyWith({
    int? id,
    String? name,
    double? weight,
    double? height,
    List<PokemonType>? types,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      types: types ?? this.types,
    );
  }


}

@HiveType(typeId: 1)
class PokemonNameAndUrl extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  const PokemonNameAndUrl(this.name, this.url);

  PokemonNameAndUrl.fromMap(Map<String, dynamic> map)
      : name = map['name'] ?? "",
        url = map['url'] ?? "";

  @override
  List<Object> get props => [name, url];
}

@HiveType(typeId: 2)
class PokemonType extends Equatable {
  @HiveField(0)
  final PokemonNameAndUrl type;

  @HiveField(1)
  final int slot;
  const PokemonType({
    required this.type,
    required this.slot,
  });

  factory PokemonType.fromMap(Map<String, dynamic> map) {
    return PokemonType(
      type: PokemonNameAndUrl.fromMap(map['type'] ?? {}),
      slot: map['slot'] ?? 0,
    );
  }

  @override
  List<Object> get props => [type, slot];
}
