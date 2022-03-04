import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:music_player/features/music_player/domain/entities/track.dart';

@immutable
abstract class MusicSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchMusicEvent extends MusicSearchEvent {
  final String? term;

  SearchMusicEvent(this.term);

  @override
  List<Object?> get props => [term];
}

class MusicPlayedEvent extends MusicSearchEvent {
  final List<Track> tracks;
  final Track? playedTrack;

  MusicPlayedEvent(this.tracks, {this.playedTrack});

  @override
  List<Object?> get props => [tracks, playedTrack];
}
