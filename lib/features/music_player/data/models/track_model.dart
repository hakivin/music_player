import 'package:music_player/features/music_player/domain/entities/track.dart';

class TrackModel extends Track {
  const TrackModel({
    required trackId,
    required kind,
    required artistName,
    required albumName,
    required trackName,
    required previewUrl,
    required artworkUrl,
    required releaseDate,
  }) : super(
          trackId: trackId,
          kind: kind,
          artistName: artistName,
          albumName: albumName,
          trackName: trackName,
          previewUrl: previewUrl,
          artworkUrl: artworkUrl,
          releaseDate: releaseDate,
        );

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      trackId: json['trackId'] ?? 0,
      kind: _convertStringToTrackKind(json['kind'] ?? ""),
      releaseDate: json['releaseDate'] ?? "",
      artworkUrl: json['artworkUrl100'] ?? "",
      previewUrl: json['previewUrl'] ?? "",
      trackName: json['trackName'] ?? "",
      albumName: json['collectionName'] ?? "",
      artistName: json['artistName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackId': trackId,
      'kind': kind.toString(),
      'releaseDate': releaseDate,
      'artworkUrl': artworkUrl,
      'previewUrl': previewUrl,
      'trackName': trackName,
      'albumName': albumName,
      'artistName': artistName,
    };
  }

  static List<TrackModel> jsonToList(List data) {
    return data.map((track) => TrackModel.fromJson(track)).toList();
  }
}

TrackKind _convertStringToTrackKind(String kind) {
  if (kind == 'song') return TrackKind.song;
  return TrackKind.other;
}
