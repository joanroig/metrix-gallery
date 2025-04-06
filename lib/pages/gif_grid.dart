import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/gif_data.dart';
import 'popup_dialog.dart';

class GifGrid extends StatelessWidget {
  final List<GifData> gifs;

  const GifGrid({super.key, required this.gifs});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: gifs.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1.75,
      ),
      itemBuilder: (context, index) {
        final gif = gifs[index];
        return GestureDetector(
          onTap: () => PopupDialog.show(context, gif.filename, gif.bgColor, gif.textColor),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: gif.filename,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
              ),
            ),
          ),
        );
      },
    );
  }
}
