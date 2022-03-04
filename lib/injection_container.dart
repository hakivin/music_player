import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/core/network/api_service/api_service.dart';
import 'package:music_player/core/network/api_service/endpoints.dart';
import 'package:music_player/features/music_player/data/datasources/music_player_remote_data_source.dart';
import 'package:music_player/features/music_player/data/repositories/music_player_repository_impl.dart';
import 'package:music_player/features/music_player/domain/repositories/music_player_repository.dart';
import 'package:music_player/features/music_player/domain/usecases/search_music.dart';
import 'package:music_player/features/music_player/presentation/bloc/bloc.dart';
import 'package:music_player/features/music_player/presentation/bloc/music_player/music_player_bloc.dart';

import 'core/audio/music_player.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await dotenv.load(fileName: ".env");
  sl.registerLazySingleton<Endpoints>(
      () => Endpoints(dotenv.env['BASE_URL'] ?? ""));
  sl.registerLazySingleton<Dio>(() {
    var dio = Dio();
    var endpoints = sl.get<Endpoints>();
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;
    dio.options.baseUrl = endpoints.baseUrl;
    return dio;
  });

  sl.registerLazySingleton<MusicPlayerInterface>(
    () => MusicPlayer(AudioPlayer()),
  );

  sl.registerLazySingleton<ApiServiceInterface>(() => ApiService(sl()));

  // data source
  sl.registerLazySingleton<MusicPlayerRemoteDataSource>(
      () => MusicPlayerRemoteDataSourceImpl(
            apiService: sl(),
            endpoints: sl(),
          ));

  // repositories
  sl.registerLazySingleton<MusicPlayerRepository>(
      () => MusicPlayerRepositoryImpl(remoteDataSource: sl()));

  // use cases
  sl.registerLazySingleton(() => SearchMusicUseCase(sl()));

  // bloc
  sl.registerFactory(() => MusicSearchBloc(sl()));
  sl.registerFactory(() => MusicPlayerBloc(sl()));
}
