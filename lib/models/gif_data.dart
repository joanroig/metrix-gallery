class GifData {
  final String filename;
  final String bgColor;
  final String textColor;
  final double contrast;
  final List<String> types;

  GifData(this.filename, this.bgColor, this.textColor, this.contrast, this.types);

  factory GifData.fromJson(Map<String, dynamic> json) {
    final filename = 'assets/gifs/${json["color1"]}_${json["color2"]}.gif';
    return GifData(filename, json["color1"], json["color2"], json["contrast"], List<String>.from(json["types"]));
  }
}
