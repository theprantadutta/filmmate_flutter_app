import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/common/movie_image_wrapper.dart';
import '../../constants/colors.dart';

class MovieSectionCachedMovieImage extends StatelessWidget {
  final String imageUrl;

  const MovieSectionCachedMovieImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => MovieImageWrapper(
        child: Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: kPrimaryColor,
            size: 45,
          ),
        ),
      ),
      cacheManager:
          CacheManager(Config(imageUrl, stalePeriod: const Duration(days: 7))),
      errorWidget: (context, url, error) => const MovieImageWrapper(
        child: Icon(
          Icons.error,
          size: 100,
          color: Colors.red,
        ),
      ),
      imageBuilder: (context, imageProvider) => MovieImageWrapper(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              imageUrl,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        // child: ElevatedButton(
        //     onPressed: _deleteCachedImage, child: const Text('Delete')),
      ),
    );
  }

  // void _deleteCachedImage() {
  //   CachedNetworkImage.evictFromCache(imageUrl);
  // }
}

class MovieSectionCachedMovieImageSkeletor extends StatelessWidget {
  const MovieSectionCachedMovieImageSkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    return MovieImageWrapper(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/d_S5gxu_S1P6NR1gXeMthZeBzkrQMHdI5uvXrpn3nfJuXpCjlqhLQKH_hbOxTHxFhp5WugVOEcl4WDrv9rmKBDOMExhKU5KmmLFQVg',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
