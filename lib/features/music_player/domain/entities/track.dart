import 'package:equatable/equatable.dart';

class Track extends Equatable {
  final int trackId;
  final String artistName;
  final String? albumName;
  final String trackName;
  final String previewUrl;
  final String artworkUrl;
  final String releaseDate;
  final TrackKind kind;

  const Track({
    required this.trackId,
    required this.kind,
    required this.artistName,
    this.albumName,
    required this.trackName,
    required this.previewUrl,
    required this.artworkUrl,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [
        trackId,
        artistName,
        albumName,
        trackName,
        previewUrl,
        artworkUrl,
      ];
}

enum TrackKind {
  song,
  other,
}
