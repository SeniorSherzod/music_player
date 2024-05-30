class Music {
  final String filePath;
  final String title;
  final String artist;
  final String? albumArtPath;

  Music({
    required this.filePath,
    required this.title,
    required this.artist,
    this.albumArtPath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Music &&
              runtimeType == other.runtimeType &&
              filePath == other.filePath;

  @override
  int get hashCode => filePath.hashCode;
}
