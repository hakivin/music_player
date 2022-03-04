import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/features/music_player/presentation/bloc/bloc.dart';
import 'package:music_player/features/music_player/presentation/bloc/music_player/music_player_bloc.dart';
import 'package:music_player/features/music_player/presentation/bloc/music_player/music_player_event.dart';
import 'package:music_player/features/music_player/presentation/bloc/music_player/music_player_state.dart';
import 'package:music_player/features/music_player/presentation/widgets/loading_widget.dart';
import 'package:music_player/features/music_player/presentation/widgets/message_display.dart';
import 'package:music_player/features/music_player/presentation/widgets/track_item.dart';
import 'package:music_player/features/music_player/presentation/widgets/tracks_display.dart';

import '../../../../injection_container.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({Key? key}) : super(key: key);

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<MusicSearchBloc>()),
            BlocProvider(create: (_) => sl<MusicPlayerBloc>()),
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener<MusicPlayerBloc, MusicPlayerState>(
                listener: (context, state) {
                  if (state is MusicPlayed) {
                    if (state.isPlaying) {
                      BlocProvider.of<MusicSearchBloc>(context).add(
                        MusicPlayedEvent(state.tracks,
                            playedTrack: state.track),
                      );
                    } else {
                      BlocProvider.of<MusicSearchBloc>(context).add(
                        MusicPlayedEvent(state.tracks),
                      );
                    }
                  }
                },
              ),
            ],
            child: Scaffold(
              backgroundColor: const Color(0xFF091227),
              resizeToAvoidBottomInset: false,
              body: buildBody(context),
              bottomSheet: buildMusicControl(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: [
          BlocBuilder<MusicSearchBloc, MusicSearchState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 8,
                ),
                child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  onSubmitted: (text) {
                    BlocProvider.of<MusicSearchBloc>(context).add(
                      SearchMusicEvent(text),
                    );
                  },
                  decoration: const InputDecoration(
                    focusColor: Colors.white,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    isDense: true,
                    hintText: 'Search...',
                  ),
                ),
              );
            },
          ),
          BlocBuilder<MusicSearchBloc, MusicSearchState>(
            builder: (context, state) {
              if (state is Empty) {
                return const MessageDisplay(
                  message: 'Start searching!',
                );
              } else if (state is Loading) {
                return const LoadingWidget();
              } else if (state is Loaded) {
                return TracksDisplay(
                  tracks: state.tracks,
                  isPlayingId: state.playedTrack?.trackId,
                  onTap: (track, index) {
                    BlocProvider.of<MusicPlayerBloc>(context).add(
                      PlayMusicEvent(
                        index,
                        track,
                        state.tracks,
                        true,
                      ),
                    );
                  },
                );
              } else if (state is Error) {
                return MessageDisplay(
                  message: state.message,
                );
              } else {
                return const LoadingWidget();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildMusicControl() {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        if (state is MusicPlayed) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF091227),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, -1), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.only(
              right: 20,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TrackItem(
                    track: state.track,
                    isPlaying: false,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<MusicPlayerBloc>(context).add(
                      PlayMusicEvent(
                        0,
                        state.track,
                        state.tracks,
                        !state.isPlaying,
                      ),
                    );
                  },
                  icon: Icon(
                    state.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
