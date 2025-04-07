import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopupDialog {
  static void show(BuildContext context, Widget preloadedImage, String bgColor, String textColor, double contrast, List<String> types) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                preloadedImage,
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(8)),
                  child: SelectableText.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Background: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '$bgColor\n'),
                        TextSpan(text: 'Text: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '$textColor\n'),
                        TextSpan(text: 'Contrast: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: contrast.toStringAsFixed(2)),
                        if (types.isNotEmpty) ...[
                          TextSpan(text: '\nTypes: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: types.join(", ")),
                        ],
                      ],
                    ),
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final textToCopy = 'TEXT_COLOR: \'$textColor\'\nBACKGROUND_COLOR: \'$bgColor\'';
                    Clipboard.setData(ClipboardData(text: textToCopy));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Metrix colors copied to clipboard!')));
                    Navigator.of(context).pop(); // Close the popup
                  },
                  child: Text('Copy Metrix Colors'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
