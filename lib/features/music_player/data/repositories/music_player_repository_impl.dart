import 'package:dartz/dartz.dart';
import 'package:music_player/core/error/exceptions.dart';
import 'package:music_player/core/error/failures.dart';
import 'package:music_player/features/music_player/data/datasources/music_player_remote_data_source.dart';
import 'package:music_player/features/music_player/data/models/search_music_api_request.dart';
import 'package:music_player/features/music_player/domain/entities/track.dart';
import 'package:music_player/features/music_player/domain/repositories/music_player_repository.dart';

class MusicPlayerRepositoryImpl extends MusicPlayerRepository {
  MusicPlayerRemoteDataSource remoteDataSource;

  MusicPlayerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Track>>> searchMusic(
      SearchMusicRequestInterface request) async {
    try {
      if (request is SearchMusicApiRequest) {
        final data = await remoteDataSource.searchMusic(request);
        return Right(data);
      } else {
        return Left(IncorrectDataFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
