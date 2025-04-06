import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/gif_data.dart';
import 'popup_dialog.dart';

class GifGrid extends StatefulWidget {
  final List<GifData> gifs;

  const GifGrid({super.key, required this.gifs});

  @override
  _GifGridState createState() => _GifGridState();
}

class _GifGridState extends State<GifGrid> {
  final ValueNotifier<int?> _hoveredIndex = ValueNotifier<int?>(null);

  @override
  void dispose() {
    _hoveredIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.gifs.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1.75,
      ),
      itemBuilder: (context, index) {
        final gif = widget.gifs[index];
        return ValueListenableBuilder<int?>(
          valueListenable: _hoveredIndex,
          builder: (context, hoveredIndex, child) {
            final isHovered = hoveredIndex == index;
            final preloadedImage = Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: gif.filename,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                ),
                if (isHovered)
                  Image.network(
                    gif.filename,
                    key: ValueKey(gif.filename),
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.error)),
                  ),
              ],
            );

            return MouseRegion(
              onEnter: (_) => _hoveredIndex.value = index,
              onExit: (_) => _hoveredIndex.value = null,
              child: GestureDetector(
                onTap: () {
                  final imageToShow =
                      preloadedImage is Image
                          ? preloadedImage
                          : Image.network(
                            gif.filename,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.error)),
                          );
                  PopupDialog.show(context, imageToShow, gif.bgColor, gif.textColor);
                },
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: ClipRRect(borderRadius: BorderRadius.circular(10), child: preloadedImage),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
