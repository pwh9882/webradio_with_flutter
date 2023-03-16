import 'package:flutter/material.dart';

class RadioChannel {
  final String radioChannelTitle, radioFreq, radioType, radioWebSlug;
  String? radioHlsSlug, radioApiSlug;
  Color? highlightColor;

  RadioChannel({
    required this.radioChannelTitle,
    required this.radioType,
    required this.radioFreq,
    required this.radioWebSlug,
    this.radioHlsSlug,
    this.radioApiSlug,
    this.highlightColor,
  });
}
// (val radioTitle: String, val radioFreq: String, val radioType: String, val radioWebSlug: String, val radioHlsSlug: String?, val radioApiSlug: String?) {
// }

class RadioChannelList {
  static final List<RadioChannel> radioList = [
    RadioChannel(
      radioChannelTitle: "KBS 제1라디오",
      radioType: "KBS",
      radioFreq: "FM 97.3㎒",
      radioWebSlug:
          "http://onair.kbs.co.kr/index.html?sname=onair&stype=live&ch_code=21#refresh",
      radioApiSlug:
          "https://cfpwwwapi.kbs.co.kr/api/v1/landing/live/channel_code/21/",
      highlightColor: const Color(0xFFeb3b5a),
    ),
    RadioChannel(
      radioChannelTitle: "KBS 제2라디오",
      radioType: "KBS",
      radioFreq: "FM 106.1㎒",
      radioWebSlug:
          "http://onair.kbs.co.kr/index.html?sname=onair&stype=live&ch_code=22#refresh",
      radioApiSlug:
          "https://cfpwwwapi.kbs.co.kr/api/v1/landing/live/channel_code/22/",
      highlightColor: const Color(0xFFfa8231),
    ),
    RadioChannel(
      radioChannelTitle: "KBS 1FM",
      radioType: "KBS",
      radioFreq: "FM 93.1㎒",
      radioWebSlug:
          "http://onair.kbs.co.kr/index.html?sname=onair&stype=live&ch_code=24#refresh",
      radioApiSlug:
          "https://cfpwwwapi.kbs.co.kr/api/v1/landing/live/channel_code/24/",
      highlightColor: const Color(0xFFf7b731),
    ),
    RadioChannel(
      radioChannelTitle: "KBS 2FM",
      radioType: "KBS",
      radioFreq: "FM 89.1㎒",
      radioWebSlug:
          "http://onair.kbs.co.kr/index.html?sname=onair&stype=live&ch_code=25#refresh",
      radioApiSlug:
          "https://cfpwwwapi.kbs.co.kr/api/v1/landing/live/channel_code/25/",
      highlightColor: const Color(0xFF20bf6b),
    ),
    RadioChannel(
      radioChannelTitle: "MBC 라디오",
      radioType: "MBC",
      radioFreq: "FM 95.9㎒",
      radioWebSlug: "http://mini.imbc.com/webapp_v3/mini.html?channel=sfm",
      radioApiSlug:
          "http://miniplay.imbc.com/WebHLS.ashx?channel=sfm&protocol=M3U8",
      highlightColor: const Color(0xFF00B061),
    ),
    RadioChannel(
      radioChannelTitle: "MBC FM4U",
      radioType: "MBC",
      radioFreq: "FM 91.9㎒",
      radioWebSlug: "http://mini.imbc.com/webapp_v3/mini.html?channel=mfm",
      radioApiSlug:
          "http://miniplay.imbc.com/WebHLS.ashx?channel=mfm&protocol=M3U8",
      highlightColor: const Color(0xFF0fb9b1),
    ),
    RadioChannel(
      radioChannelTitle: "SBS 러브FM",
      radioType: "SBS",
      radioFreq: "FM 103.5㎒",
      radioWebSlug: "http://play.sbs.co.kr/onair/pc/index.html?id=S08",
      radioHlsSlug: null,
      radioApiSlug:
          "http://apis.sbs.co.kr/play-api/1.0/onair/channel/S08?protocol=hls",
      highlightColor: const Color(0xFF2d98da),
    ),
    RadioChannel(
      radioChannelTitle: "SBS 파워FM",
      radioType: "SBS",
      radioFreq: "FM 107.7㎒",
      radioWebSlug: "http://play.sbs.co.kr/onair/pc/index.html?id=S07",
      radioHlsSlug: null,
      radioApiSlug:
          "http://apis.sbs.co.kr/play-api/1.0/onair/channel/S07?protocol=hls",
      highlightColor: const Color(0xFF3867d6),
    ),
    RadioChannel(
      radioChannelTitle: "CBS 음악FM",
      radioType: "CBS",
      radioFreq: "FM 93.9㎒",
      radioWebSlug: "http://www.cbs.co.kr/radio/frame/AodJwPlayer.asp#refresh",
      radioHlsSlug:
          "http://aac.cbs.co.kr/cbs939/definst/cbs939.stream/playlist.m3u8",
      radioApiSlug: null,
      highlightColor: const Color(0xFF8854d0),
    ),
    RadioChannel(
      radioChannelTitle: "CBS 표준FM",
      radioType: "CBS",
      radioFreq: "FM 98.1㎒",
      radioWebSlug: "http://www.cbs.co.kr/radio/frame/AodJwPlayer.asp",
      radioHlsSlug:
          "http://aac.cbs.co.kr/cbs981/definst/cbs981.stream/playlist.m3u8",
      radioApiSlug: null,
      highlightColor: const Color(0xFF4A3A95),
    ),
    RadioChannel(
      radioChannelTitle: "TBS 교통방송",
      radioType: "TBS",
      radioFreq: "FM 95.1㎒",
      radioWebSlug: "http://tbs.seoul.kr/player/live.do?channelCode=CH_A",
      radioHlsSlug: "http://58.234.158.60:1935/fmlive/myStream/playlist.m3u8",
      radioApiSlug: null,
      highlightColor: const Color(0xFF4b6584),
    ),
// Radio(
// radioTitle: "TBS eFM",
// radioType: "TBS",
// radioFreq: "FM 101.3㎒",
// radioWebSlug: "http://tbs.seoul.kr/player/live.do?channelCode=CH_E",
// radioHlsSlug: "http://58.234.158.60:1935/efmlive/myStream/playlist.m3u8",
// radioApiSlug: null,
// ),
    RadioChannel(
      radioChannelTitle: "EBS FM 교육방송",
      radioType: "EBS",
      radioFreq: "FM 104.5㎒",
      radioWebSlug: "http://www.ebs.co.kr/radio/home?mainTop",
      radioHlsSlug:
          "http://ebsonair.ebs.co.kr/fmradiofamilypc/familypc1m/playlist.m3u8",
      radioApiSlug: null,
      highlightColor: const Color(0xFF394454),
    ),
  ];
}
