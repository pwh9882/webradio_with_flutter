import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
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
  var isSelectedList = [
    for (var iter = 0; iter < RadioChannelList.radioList.length; iter++) false
  ];

  void onPauseButtonClicked() {
    isPlaying = false;
    widget.audioHandler.pause();

    //_listenToPlaybackState에서 setState 책임짐
    // setState(() {});
  }

  Future<Uri> getImageFileFromAssets() async {
    final byteData = await rootBundle.load('images/noti_art.jpeg');
    final buffer = byteData.buffer;
    Directory tempDir = await getApplicationDocumentsDirectory();

    String tempPath = tempDir.path;
    var filePath =
        '$tempPath/file_01.png'; // file_01.tmp is dump file, can be anything
    return (await File(filePath).writeAsBytes(
            buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)))
        .uri;
  }

  void loadHlsSlugAndPlay() async {
    // hls 주소를 불러와 오디오 재생
    selectedRadioHlsSlug = selectedRadio?.radioHlsSlug;
    selectedRadioHlsSlug ??= await parseHlsSlugFromApiSlug(selectedRadio!);

    var audioItem = MediaItem(
      id: selectedRadioHlsSlug!,
      album: selectedRadioChannelTitle,
      title: '',
      // artUri: Uri.file('images/radioIcon.png'),
      // artUri: await getImageFileFromAssets(),
      // artUri: Uri.parse("file:///" "images/radioIcon.png")
      // artUri: myImageUri,
    );
    widget.audioHandler.clearQueue();
    widget.audioHandler.mediaItem.add(audioItem);
    print("play!!");
    widget.audioHandler.playMediaItem(audioItem);
    isPlaying = true;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 30), loadTitle);
    loadTitle(timer!);
  }

  void loadTitle(Timer timer) async {
    selectedRadioTitle = await parseTitle(selectedRadio!);
    widget.audioHandler.updateCurrentMediaItemTitle(selectedRadioTitle);

    //_listenToPlaybackState에서 setState 책임짐
    // setState(() {});
  }

  void onPlayButtonClicked() async {
    if (selectedRadio == null) {
    } else {
      try {
        // 변수 초기화
        isPlaying = false;

        await widget.audioHandler.pause();

        selectedRadioTitle = "로딩중...";
        selectedRadioChannelTitle = selectedRadio!.radioChannelTitle;
        selectedRadioFreq = selectedRadio!.radioFreq;

        loadHlsSlugAndPlay();

        // print("play!");
      } catch (e) {}
    }
  }

  void onExitButtonClicked() async {
    widget.audioHandler.dispose();

    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
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
      if (playbackState.controls[0].label == 'Stop') {
        onExitButtonClicked();
        // print("\n\nStop!!!!!\n\n");
      }
      // print("\n\n\n${playbackState.controls[0].label}\n\n\n");
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
    // print(isSelectedList.length);
    _listenToPlaybackState();
    return Scaffold(
      body: Column(children: [
        // 제목 디스플레이
        Flexible(
          flex: 12,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/info_background.jpg'),
                opacity: 0.65,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 48),
                      child: Text(
                        selectedRadioTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        selectedRadioFreq,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: selectedRadio == null
                              ? Colors.white
                              : selectedRadio!.highlightColor,
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
            flex: 8,
            child: SingleChildScrollView(
              child: Column(children: [
                for (var radio in RadioChannelList.radioList)
                  Material(
                    color: isSelectedList[
                            RadioChannelList.radioList.indexOf(radio)]
                        ? Color.lerp(radio.highlightColor, Colors.black, 0.5)
                        : radio.highlightColor,
                    child: InkWell(
                      splashColor: Colors.black54,
                      onTap: () {
                        for (int iter = 0;
                            iter < isSelectedList.length;
                            iter++) {
                          isSelectedList[iter] = false;
                        }
                        isSelectedList[
                            RadioChannelList.radioList.indexOf(radio)] = true;
                        selectedRadio = radio;
                        onPlayButtonClicked();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 18),
                        // decoration: const BoxDecoration(
                        //   // color: radio.highlightColor,
                        //   border: Border(
                        //     bottom: BorderSide(
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              radio.radioChannelTitle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelectedList[RadioChannelList.radioList
                                        .indexOf(radio)]
                                    ? Colors.white38
                                    : Colors.white,
                              ),
                            ),
                            Text(
                              radio.radioFreq,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelectedList[RadioChannelList.radioList
                                        .indexOf(radio)]
                                    ? Colors.white38
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ]),
            )),
        // 재생버튼
        Flexible(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/player_background.jpg'),
                opacity: 0.7,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        // child: Image.asset('images/radioIcon.png'),
                        )),
                Center(
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                        color: Colors.white,
                        iconSize: 90,
                        onPressed: isPlaying
                            ? onPauseButtonClicked
                            : onPlayButtonClicked,
                        icon: isPlaying
                            ? const Icon(Icons.pause_circle_filled)
                            : const Icon(Icons.play_circle_fill)),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "EXIT",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            color: Colors.white,
                            onPressed: onExitButtonClicked,
                            icon: const Icon(Icons.exit_to_app),
                          ),
                        ],
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
