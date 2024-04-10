class PhotoEntity {
  final int? orientation;
  final bool? thumbnail;
  final String? filename;
  final String? format;
  final int? width;
  final String? id;
  final int? height;
  final String? url;

  const PhotoEntity({
    required this.orientation,
    required this.thumbnail,
    required this.filename,
    required this.format,
    required this.width,
    required this.id,
    required this.height,
    required this.url,
  });
}