import 'dart:convert';

import 'package:music_player/core/network/api_service/api_service.dart';
import 'package:music_player/core/network/api_service/endpoints.dart';
import 'package:music_player/features/music_player/data/models/search_music_api_request.dart';
import 'package:music_player/features/music_player/data/models/track_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class MusicPlayerRemoteDataSource {
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<TrackModel>> searchMusic(SearchMusicApiRequest request);
}

class MusicPlayerRemoteDataSourceImpl implements MusicPlayerRemoteDataSource {
  ApiServiceInterface apiService;
  Endpoints endpoints;

  MusicPlayerRemoteDataSourceImpl({
    required this.apiService,
    required this.endpoints,
  });

  @override
  Future<List<TrackModel>> searchMusic(SearchMusicApiRequest request) async {
    final response = await apiService.get(endpoints.search, request);
    return TrackModel.jsonToList(jsonDecode(response.data)['results']);
  }
}
