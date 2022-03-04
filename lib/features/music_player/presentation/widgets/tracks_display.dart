import 'package:flutter/material.dart';
import 'package:music_player/features/music_player/domain/entities/track.dart';
import 'package:music_player/features/music_player/presentation/widgets/track_item.dart';

class TracksDisplay extends StatelessWidget {
  final List<Track> tracks;
  final Function(Track, int)? onTap;
  final int? isPlayingId;

  const TracksDisplay({
    required this.tracks,
    this.onTap,
    this.isPlayingId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          return TrackItem(
            track: tracks[index],
            isPlaying: tracks[index].trackId == isPlayingId,
            onTap: () {
              /// [onTap] still need null-check because older version of dart
              /// did not know if it is null or not in build time. This is fixed
              /// in newer version of dart.
              if (onTap != null) onTap!(tracks[index], index);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 0,
            color: Colors.black54,
          );
        },
      ),
    );
  }
}
