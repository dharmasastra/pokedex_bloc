import 'package:flutter/material.dart';
import 'package:pokedex_bloc/config/constants.dart';
import 'package:pokedex_bloc/config/theme.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';

class PokemonInfoHeader extends StatelessWidget {
  final Pokemon pokemon;

  PokemonInfoHeader({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Insets.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PokemonDataItemTile("Height", "${pokemon.height}"),
          _PokemonDataItemTile("Weight", "${pokemon.weight}"),
          _PokemonDataItemTile("BMI", pokemon.bmi.toStringAsFixed(2)),
        ],
      ),
    );
  }

  // @override
  // double get maxExtent => 78;

  // @override
  // double get minExtent => 78;

  // @override
  // bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
  //     this != oldDelegate;
}

class _PokemonDataItemTile extends StatelessWidget {
  final String title;
  final String value;
  const _PokemonDataItemTile(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textBodyColor,
            ),
          ),
          const SizedBox(height: Insets.xs),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
