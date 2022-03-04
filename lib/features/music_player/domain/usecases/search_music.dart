import 'package:dartz/dartz.dart';
import 'package:music_player/core/usecases/usecases.dart';
import 'package:music_player/features/music_player/domain/entities/track.dart';
import 'package:music_player/features/music_player/domain/repositories/music_player_repository.dart';

import '../../../../core/error/failures.dart';

class SearchMusicUseCase implements UseCase<List<Track>, SearchMusicRequestInterface> {
  final MusicPlayerRepository repository;

  SearchMusicUseCase(this.repository);

  @override
  Future<Either<Failure, List<Track>>> call(SearchMusicRequestInterface params) async {
    return await repository.searchMusic(params);
  }
}
