import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId:
          'com.woohyeok.webradiowithflutter.channel.audio',
      androidNotificationChannelName: 'Music playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidNotificationIcon: 'mipmap/ic_launcher',
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  // mix in default seek callback implementations
  final _player = AudioPlayer();

  @override
  MyAudioHandler() {
    _notifyAudioHandlerAboutPlaybackEvents();
    // Broadcast that we're loading, and what controls are available.
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.play],
      processingState: AudioProcessingState.loading,
    ));
  }

  // The most common callbacks:
  @override
  Future<void> play() async {
    // All 'play' requests from all origins route to here. Implement this
    // callback to start playing audio appropriate to your app. e.g. music.
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: [MediaControl.pause],
    ));

    await _player.play();
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) {
    _player.setUrl(mediaItem.id, preload: false);

    // playbackState.add(playbackState.value
    //     .copyWith(processingState: AudioProcessingState.idle));
    // updateMediaItem(mediaItem);
    // this.mediaItem.add(mediaItem);
    // this.mediaItem.
    // playbackState.add(playbackState.value
    //     .copyWith(processingState: AudioProcessingState.ready));

    _player.play();
    return super.playMediaItem(mediaItem);
  }

  updateCurrentMediaItemTitle(
    String title,
  ) async {
    // print(mediaItem.value);
    var item = MediaItem(
      id: mediaItem.value!.id,
      album: mediaItem.value!.album,
      title: title,
      artUri: mediaItem.value!.artUri,
    );
    clearQueue();
    mediaItem.add(item);
  }

  @override
  Future<void> pause() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [MediaControl.play],
    ));

    await _player.pause();
  }

  @override
  Future<void> stop() async {
    // await _player.dispose();
    // return super.stop();
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.stop],
    ));
  }

  void dispose() async {
    await _player.dispose();
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          // MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          // MediaControl.skipToNext,
        ],
        systemActions: const {
          // MediaAction.seek,
        },
        androidCompactActionIndices: const [0],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,
      ));
    });
  }

  void clearQueue() {
    while (queue.value.isNotEmpty) {
      queue.value.removeLast();
    }
  }
}
