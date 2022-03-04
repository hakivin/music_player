import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:music_player/features/music_player/domain/entities/track.dart';

@immutable
abstract class MusicPlayerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlayMusicEvent extends MusicPlayerEvent {
  final int index;
  final Track track;
  final List<Track> tracks;
  final bool isPlaying;

  PlayMusicEvent(
      this.index,
      this.track,
      this.tracks,
      this.isPlaying,
      );

  @override
  List<Object?> get props => [track, isPlaying];
}
