import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/config/constants.dart';
import 'package:pokedex_bloc/config/theme.dart';
import 'package:pokedex_bloc/core/utils/pokemon_type.dart';
import 'package:pokedex_bloc/core/widgets/image.dart';
import 'package:pokedex_bloc/data/model/pokemon.dart';
import 'package:pokedex_bloc/persentation/bloc/favorite_pokemon_cubit.dart';
import 'package:pokedex_bloc/persentation/bloc/pokemon_cubit.dart';
import 'package:pokedex_bloc/persentation/pokemon_info/widget/floating_button.dart';
import 'package:pokedex_bloc/persentation/pokemon_info/widget/pokemon_info_header.dart';

class PokemonInfo extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonInfo({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonInfo> createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<PokemonInfo> {
  late ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });

    context.read<PokemonCubit>().getPokemonById(widget.pokemon.id);
  }

  bool get isAppBarExpanded {
    return scrollController.hasClients &&
        scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final bool isMarkedAsFavourite = context
        .watch<FavoritePokemonCubit>()
        .state
        .data
        .any((favourite) => favourite.id == widget.pokemon.id);

    final pokemonCubit = context.watch<PokemonCubit>();
    final pokemon = pokemonCubit.state.data.firstWhere(
      (e) => e.id == widget.pokemon.id && e.hasAdditionalInfo,
      orElse: () => widget.pokemon,
    );

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          if (pokemonCubit.state.isLoading) ...[
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
          ] else ...[
            SliverAppBar(
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  CupertinoIcons.chevron_back,
                  color: Colors.black,
                ),
              ),
              pinned: true,
              elevation: 0,
              expandedHeight: MediaQuery.of(context).size.height,
              backgroundColor: isAppBarExpanded
                  ? getTypeColor(pokemon.baseType)
                  : getTypeColor(pokemon.baseType).withOpacity(0.1),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.only(
                  left: Insets.md,
                  bottom: Insets.md,
                ),
                background: FlexibleBackground(pokemon),
              ),
            ),
          ]
        ],
      ),
      floatingActionButton: FloatingButton(
        pokemon,
        isPokemonMarkedAsFavourite: isMarkedAsFavourite,
      ),
    );
  }
}

class FlexibleBackground extends StatelessWidget {
  final Pokemon pokemon;
  const FlexibleBackground(this.pokemon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              pokemon.name.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
                fontSize: 27,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: Insets.md,
            ),
            Text(
              pokemon.types
                  .map((type) => type.type.name.toUpperCase())
                  .join(", "),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.5),
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: Insets.md,
            ),
            Text(
              pokemon.pokedexId,
              style: const TextStyle(
                color: AppColors.textPrimaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Hero(
              tag: ValueKey(pokemon.id),
              child: PokemonsImage(
                url: pokemon.imageUrl,
                height: 250,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            PokemonInfoHeader(
              pokemon: pokemon,
            ),
          ],
        ),
      ),
    );
  }
}
