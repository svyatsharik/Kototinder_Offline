import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final Color placeholderColor;
  final double placeholderSize;
  final Color errorIconColor;
  final double errorIconSize;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 8.0,
    this.placeholderColor = Colors.white,
    this.placeholderSize = 24.0,
    this.errorIconColor = Colors.white,
    this.errorIconSize = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        progressIndicatorBuilder:
            (context, url, progress) => Center(
              child: SizedBox(
                width: placeholderSize,
                height: placeholderSize,
                child: CircularProgressIndicator(
                  value: progress.progress,
                  color: placeholderColor,
                  strokeWidth: 2.0,
                ),
              ),
            ),
        errorWidget:
            (context, url, error) => Icon(
              Icons.error_outline,
              size: errorIconSize,
              color: errorIconColor,
            ),
      ),
    );
  }
}
