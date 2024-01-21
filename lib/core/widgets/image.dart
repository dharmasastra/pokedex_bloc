import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class PokemonsImage extends StatelessWidget {
  const PokemonsImage({
    super.key,
    required this.url,
    this.boxFIt = BoxFit.contain,
    this.height,
    this.width,
  });

  final String url;
  final BoxFit boxFIt;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: boxFIt,
      height: height,
      width: width,
      progressIndicatorBuilder: (_, string, progress) =>
          CupertinoActivityIndicator.partiallyRevealed(
        progress: progress.progress ?? 1,
      ),
      errorWidget: (_, string, ___) {
        return const Padding(
          padding: EdgeInsets.all(22),
          child: LocalImage(image: 'assets/images/pokeball.png'),
        );
      },
      fadeInDuration: const Duration(seconds: 1),
    );
  }
}

class LocalImage extends StatelessWidget {
  const LocalImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.boxfit = BoxFit.contain,
  });

  final String image;
  final double? height;
  final double? width;
  final BoxFit boxfit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: height,
      width: width,
      fit: boxfit,
    );
  }
}
