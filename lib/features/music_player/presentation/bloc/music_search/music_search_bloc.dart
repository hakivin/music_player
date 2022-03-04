import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/core/error/failures.dart';
import 'package:music_player/features/music_player/data/models/search_music_api_request.dart';
import 'package:music_player/features/music_player/domain/entities/track.dart';
import 'package:music_player/features/music_player/domain/usecases/search_music.dart';
import 'package:music_player/features/music_player/presentation/bloc/bloc.dart';

class MusicSearchBloc extends Bloc<MusicSearchEvent, MusicSearchState> {
  SearchMusicUseCase searchMusic;

  MusicSearchBloc(
    this.searchMusic,
  ) : super(Empty());

  @override
  Stream<MusicSearchState> mapEventToState(MusicSearchEvent event) async* {
    if (event is SearchMusicEvent) {
      yield Loading();
      final failureOrTracks = await searchMusic.call(
        SearchMusicApiRequest(term: event.term ?? ""),
      );
      yield* _eitherLoadedOrErrorState(failureOrTracks);
    } else if (event is MusicPlayedEvent) {
      yield Loaded(tracks: event.tracks, playedTrack: event.playedTrack);
    }
  }

  Stream<MusicSearchState> _eitherLoadedOrErrorState(
    Either<Failure, List<Track>> failureOrTracks,
  ) async* {
    yield failureOrTracks.fold((failure) => Error(message: "Server error"),
        (tracks) {
      tracks.removeWhere((element) => element.kind == TrackKind.other);
      return Loaded(tracks: tracks);
    });
  }
}
