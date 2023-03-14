import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:webradio_with_flutter/models/radio_channel.dart';
import 'package:webradio_with_flutter/services/audio_service.dart';
import 'package:webradio_with_flutter/services/parse_hls_slug.dart';
import 'package:webradio_with_flutter/services/parse_title.dart';

class HomePage extends StatefulWidget {
  final MyAudioHandler audioHandler;

  const HomePage({super.key, required this.audioHandler});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPlaying = false;
  RadioChannel? selectedRadio;
  String selectedRadioTitle = "리스트에서 선택해 주세요";
  String selectedRadioChannelTitle = "라디오";
  String selectedRadioFreq = "00.00㎒";
  Timer? timer;
  StreamSubscription<PlaybackState>? _playerStateSubscription;
  String? selectedRadioHlsSlug;

  void onPauseButtonClicked() {
    isPlaying = false;
    widget.audioHandler.pause();
    // timer?.cancel();
    setState(() {});
  }

  void loadHlsSlugAndPlay() async {
    // hls 주소를 불러와 오디오 재생
    selectedRadioHlsSlug = selectedRadio?.radioHlsSlug;
    selectedRadioHlsSlug ??= await parseHlsSlugFromApiSlug(selectedRadio!);

    var audioItem = MediaItem(
      id: selectedRadioHlsSlug!,
      album: selectedRadioChannelTitle,
      title: 'Title Defualt',
      // artist: 'Artist name',
      // artUri: Uri.parse(
      //     'file:///Users/woohyeok/AndroidStudioProjects/WebRadioApplicationWithFlutter/webradio_with_flutter/lib/imgs/radio_icon.png'),
    );
    // widget.audioHandler.();
    widget.audioHandler.clearQueue();
    widget.audioHandler.mediaItem.add(audioItem);
    widget.audioHandler.playMediaItem(audioItem);

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 30), loadTitle);
    loadTitle(timer!);
  }

  void loadTitle(Timer timer) async {
    selectedRadioTitle = await parseTitle(selectedRadio!);
    var audioItem = MediaItem(
      id: selectedRadioHlsSlug!,
      album: selectedRadioChannelTitle,
      title: selectedRadioTitle,
      // artist: 'Artist name',
      // artUri: Uri.parse(
      //     'file:///Users/woohyeok/AndroidStudioProjects/WebRadioApplicationWithFlutter/webradio_with_flutter/lib/imgs/radio_icon.png'),
    );
    // widget.audioHandler.queueTitle = 'asf'; // print("Timer running.....");
    widget.audioHandler.clearQueue();
    widget.audioHandler.mediaItem.add(audioItem);
    setState(() {});
  }

  void onPlayButtonClicked() {
    if (selectedRadio == null) {
    } else {
      // 변수 초기화
      isPlaying = false;
      widget.audioHandler.pause();
      selectedRadioTitle = "로딩중...";
      selectedRadioChannelTitle = selectedRadio!.radioChannelTitle;
      selectedRadioFreq = selectedRadio!.radioFreq;

      loadHlsSlugAndPlay();

      // widget.audioHandler._notifyAudioHandlerAboutPlaybackEvents();

      print("play!");

      //
      isPlaying = true;
      setState(() {});
    }
  }

  void onExitButtonClicked() {
    var audioItem = MediaItem(
      id: selectedRadioHlsSlug!,
      album: selectedRadioChannelTitle,
      title: "asdf",
      // artist: 'Artist name',
      // artUri: Uri.parse(
      //     'file:///Users/woohyeok/AndroidStudioProjects/WebRadioApplicationWithFlutter/webradio_with_flutter/lib/imgs/radio_icon.png'),
    );
    // widget.audioHandler.queueTitle = 'asf'; // print("Timer running.....");
    widget.audioHandler.clearQueue();
    widget.audioHandler.mediaItem.add(audioItem);
  }

  void _listenToPlaybackState() {
    _playerStateSubscription =
        widget.audioHandler.playbackState.listen((playbackState) {
      isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        // playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        // playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        // playButtonNotifier.value = ButtonState.playing;
      } else {
        // widget.audioHandler.seek(Duration.zero);
        widget.audioHandler.pause();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // for (var radio in RadioList.radioList) {
    //   print(parseTitle(radio));
    // }
    _listenToPlaybackState();
    return Scaffold(
      body: Column(children: [
        // 제목 디스플레이
        Flexible(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(color: Colors.grey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      selectedRadioTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        selectedRadioChannelTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        selectedRadioFreq,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // 리스트뷰 라디오 목록
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(color: Colors.blue.shade200),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: RadioChannelList.radioList.length,
              itemBuilder: (context, index) {
                var radio = RadioChannelList.radioList[index];
                return GestureDetector(
                  onTap: () {
                    selectedRadio = radio;
                    onPlayButtonClicked();
                    // print(radio.radioTitle);

                    // RadioPlayer.playRadio(radio);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 18),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          radio.radioChannelTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          radio.radioFreq,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 1);
              },
            ),
          ),
        ),
        // 재생버튼
        Flexible(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(color: Colors.blueGrey),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox()),
                Center(
                  child: IconButton(
                      iconSize: 70,
                      onPressed: isPlaying
                          ? onPauseButtonClicked
                          : onPlayButtonClicked,
                      icon: isPlaying
                          ? const Icon(Icons.pause_circle_filled)
                          : const Icon(Icons.play_circle_fill)),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: onExitButtonClicked,
                        icon: const Icon(Icons.exit_to_app),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
