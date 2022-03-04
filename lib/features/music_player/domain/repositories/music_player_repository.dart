import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/core/error/failures.dart';
import 'package:music_player/features/music_player/domain/entities/track.dart';

abstract class MusicPlayerRepository {
  Future<Either<Failure, List<Track>>> searchMusic(SearchMusicRequestInterface request);
}

abstract class SearchMusicRequestInterface extends Equatable {}
