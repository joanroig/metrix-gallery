import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopupDialog {
  static void show(BuildContext context, Widget preloadedImage, String bgColor, String textColor, double contrast, List<String> types) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final dialogSize = MediaQuery.of(context).size;
        final isMobile = dialogSize.width < 500;

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600), // Limit the width of the dialog
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  preloadedImage,
                  SizedBox(height: 20),
                  isMobile
                      ? Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Properties',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                              ),
                              SizedBox(height: 8),
                              Container(
                                constraints: BoxConstraints(minWidth: 400), // Limit the width of the box
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
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Metrix Colors',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                              ),
                              SizedBox(height: 8),
                              Container(
                                constraints: BoxConstraints(minWidth: 400), // Limit the width of the box
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(8)),
                                child: SelectableText(
                                  'TEXT_COLOR: \'$textColor\'\nBACKGROUND_COLOR: \'$bgColor\'',
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the boxes
                        crossAxisAlignment: CrossAxisAlignment.start, // Align boxes at the top
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Properties',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  constraints: BoxConstraints(minWidth: 400), // Limit the width of the box
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
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Metrix Colors',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  constraints: BoxConstraints(minWidth: 400), // Limit the width of the box
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(8)),
                                  child: SelectableText(
                                    'TEXT_COLOR: \'$textColor\'\nBACKGROUND_COLOR: \'$bgColor\'',
                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  SizedBox(height: 20),
                  isMobile
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 170, maxWidth: 200),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(height: 10),
                          ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 170, maxWidth: 200),
                            child: ElevatedButton(
                              onPressed: () {
                                final textToCopy = 'TEXT_COLOR: \'$textColor\'\nBACKGROUND_COLOR: \'$bgColor\'';
                                Clipboard.setData(ClipboardData(text: textToCopy));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Metrix colors copied to clipboard!')));
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                              child: Text('Copy Metrix Colors', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 170, maxWidth: 200),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(width: 10),
                          ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 170, maxWidth: 200),
                            child: ElevatedButton(
                              onPressed: () {
                                final textToCopy = 'TEXT_COLOR: \'$textColor\'\nBACKGROUND_COLOR: \'$bgColor\'';
                                Clipboard.setData(ClipboardData(text: textToCopy));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Metrix colors copied to clipboard!')));
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                              child: Text('Copy Metrix Colors', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
