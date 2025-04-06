import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopupDialog {
  static void show(BuildContext context, Widget preloadedImage, String bgColor, String textColor) {
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
                Text(
                  'BACKGROUND_COLOR: \'$bgColor\'\nTEXT_COLOR: \'$textColor\'',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final textToCopy = 'BACKGROUND_COLOR: \'$bgColor\'\nTEXT_COLOR: \'$textColor\'';
                    Clipboard.setData(ClipboardData(text: textToCopy));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied to clipboard!')));
                  },
                  child: Text('Copy to Clipboard'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
