import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:music_player/features/music_player/domain/entities/track.dart';

@immutable
abstract class MusicPlayerState extends Equatable {
  @override
  List<Object> get props => [];
}

class Initial extends MusicPlayerState {}

class MusicPlayed extends MusicPlayerState {
  final Track track;
  final List<Track> tracks;
  final bool isPlaying;

  MusicPlayed({
    required this.track,
    required this.tracks,
    required this.isPlaying,
  });

  @override
  List<Object> get props => [track, isPlaying];
}
