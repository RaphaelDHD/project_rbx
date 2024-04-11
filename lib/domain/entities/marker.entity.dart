class MarkerEntity {
  final double lat;
  final double long;
  final String title;
  final String imageUrl;
  final int monumentIndex;

  MarkerEntity({
    required this.lat,
    required this.long,
    required this.title,
    required this.imageUrl,
    required this.monumentIndex,
  });
}