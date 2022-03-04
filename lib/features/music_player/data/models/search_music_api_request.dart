import 'package:music_player/core/network/api_service/api_request_interface.dart';
import 'package:music_player/features/music_player/domain/repositories/music_player_repository.dart';

class SearchMusicApiRequest implements SearchMusicRequestInterface, ApiRequestInterface {
  final String term;

  const SearchMusicApiRequest({required this.term});

  @override
  List<Object> get props => [term];

  @override
  Map<String, dynamic> encode() {
    return {
      'term': term,
    };
  }

  @override
  bool? get stringify => false;
}