import 'package:flutter/material.dart';

import '../dialogs/popup_dialog.dart';
import '../models/gif_data.dart';

class GifGrid extends StatefulWidget {
  final List<GifData> gifs;

  const GifGrid({super.key, required this.gifs});

  @override
  GifGridState createState() => GifGridState();
}

class GifGridState extends State<GifGrid> {
  final ValueNotifier<int?> _hoveredIndex = ValueNotifier<int?>(null);

  @override
  void dispose() {
    _hoveredIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = 622 / 356;
    return GridView.builder(
      itemCount: widget.gifs.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 450,
        crossAxisSpacing: 0,
        mainAxisSpacing: 2,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (context, index) {
        final gif = widget.gifs[index];
        return ValueListenableBuilder<int?>(
          valueListenable: _hoveredIndex,
          builder: (context, hoveredIndex, child) {
            final preloadedImage = ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                gif.filename,
                key: ValueKey(gif.filename),
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: frame != null ? child : AspectRatio(aspectRatio: aspectRatio, child: Center(child: const CircularProgressIndicator())),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.error)),
              ),
            );

            return MouseRegion(
              onEnter: (_) => _hoveredIndex.value = index,
              onExit: (_) => _hoveredIndex.value = null,
              child: GestureDetector(
                onTap: () {
                  final imageToShow = preloadedImage;
                  PopupDialog.show(context, imageToShow, gif.bgColor, gif.textColor, gif.contrast, gif.types);
                },
                child: Center(
                  child: Stack(
                    children: [
                      Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 4, child: preloadedImage),
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: hoveredIndex == index ? 1.0 : 0.0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withValues(alpha: 0.3), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 2)),
                              ],
                            ),
                            constraints: BoxConstraints(maxHeight: 100),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Background: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: '${gif.bgColor}\n'),
                                  TextSpan(text: 'Text: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: '${gif.textColor}\n'),
                                  TextSpan(text: 'Contrast: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: gif.contrast.toStringAsFixed(2)),
                                  if (gif.types.isNotEmpty) ...[
                                    TextSpan(text: '\nTypes: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: gif.types.join(", ")),
                                  ],
                                ],
                              ),
                              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
