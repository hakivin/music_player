import 'package:just_audio/just_audio.dart';

abstract class MusicPlayerInterface {
  Future<void> play(String url);

  Future<void> pause();

  Future<void> stop();

  Future<void> resume();

  bool get isPlaying;

  String? get currentTrackUrl;
}

class MusicPlayer extends MusicPlayerInterface {
  final AudioPlayer audioPlayer;

  String? playedTrackUrl;

  MusicPlayer(this.audioPlayer);

  @override
  Future<void> pause() async {
    await audioPlayer.pause();
  }

  @override
  Future<void> play(String url) async {
    Duration? duration;
    try {
      if (playedTrackUrl != url) {
        if (isPlaying) {
          audioPlayer.stop();
        }
        // duration = await audioPlayer.setUrl(url);
        playedTrackUrl = url;
        var source = AudioSource.uri(Uri.parse(url));
        duration = await audioPlayer.setAudioSource(source, preload: true);
      }
      await audioPlayer.play();
      if (duration != null && audioPlayer.position.compareTo(duration) >= 0) {
        playedTrackUrl = null;
      }
    } on PlayerException catch (e) {
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // Linux/Windows: maps to PlayerErrorCode.index
      print("Error code: ${e.code}");
      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web/Linux: a generic message
      // Windows: MediaPlayerError.message
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // Fallback for all errors
      print(e);
    }
  }

  @override
  Future<void> resume() async {
    await audioPlayer.play();
  }

  @override
  Future<void> stop() async {
    await audioPlayer.stop();
  }

  @override
  bool get isPlaying => audioPlayer.playing;

  @override
  String? get currentTrackUrl => playedTrackUrl;
}
