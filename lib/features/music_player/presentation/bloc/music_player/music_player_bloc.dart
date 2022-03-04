import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/core/audio/music_player.dart';
import 'package:music_player/features/music_player/domain/entities/track.dart';

import 'music_player_event.dart';
import 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  MusicPlayerInterface musicPlayer;

  MusicPlayerBloc(
    this.musicPlayer,
  ) : super(Initial());

  @override
  Stream<MusicPlayerState> mapEventToState(MusicPlayerEvent event) async* {
    if (event is PlayMusicEvent) {
      if (event.isPlaying) {
        Track playedTrack = event.tracks.removeAt(event.index);
        event.tracks.insert(0, playedTrack);
        yield MusicPlayed(
          track: event.track,
          tracks: event.tracks,
          isPlaying: true,
        );
        if (musicPlayer.isPlaying) {
          // await musicPlayer.pause();
          // musicPlayer.resume();
          // await musicPlayer.pause();
          // await Future.delayed(const Duration(seconds: 3));
        }
        musicPlayer.play(event.track.previewUrl).then((value) {
          return add(PlayMusicEvent(0, event.track, event.tracks, false));
        });
      } else {
        if (event.track.previewUrl == musicPlayer.currentTrackUrl || musicPlayer.currentTrackUrl == null) {
          await musicPlayer.pause();
          yield MusicPlayed(
            track: event.track,
            tracks: event.tracks,
            isPlaying: false,
          );
        }
      }
    }
  }
}
