import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget ImageUrl(String url, double? size){
  return SizedBox(
    width: size ?? 50,
    height: size ?? 50,
    child: ClipOval( // Clip the image into a circle
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Container(
          color: Colors.white,
          child: Image.asset(
            'lib/assets/images/img.png',
            fit: BoxFit.cover,
          ),
        ),
        fit: BoxFit.cover,
      ),
    ),
  );
}
