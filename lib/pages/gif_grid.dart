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
              child: Image.network(
                gif.filename,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return AnimatedOpacity(opacity: 1.0, duration: Duration(milliseconds: 500), child: child);
                  }
                  return AnimatedOpacity(opacity: 0.0, duration: Duration(milliseconds: 500), child: SizedBox.shrink());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.error));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
