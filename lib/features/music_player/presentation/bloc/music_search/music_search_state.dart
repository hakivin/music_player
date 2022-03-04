import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:music_player/features/music_player/domain/entities/track.dart';

@immutable
abstract class MusicSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends MusicSearchState {}

class Loading extends MusicSearchState {}

class Loaded extends MusicSearchState {
  final List<Track> tracks;
  final Track? playedTrack;

  Loaded({
    required this.tracks,
    this.playedTrack,
  });

  @override
  List<Object> get props => [tracks, playedTrack ?? Object()];
}

class Error extends MusicSearchState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
