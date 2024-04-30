class Image {
  double aspectRatio;
  int height;
  int width;
  String? filePath;

  Image({
    required this.aspectRatio,
    required this.height,
    required this.width,
    this.filePath,
  });
}
