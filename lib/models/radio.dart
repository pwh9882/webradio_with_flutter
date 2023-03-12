class Radio {
  final String radioTitle, radioFreq, radioType, radioWebSlug;
  String? radioHlsSlug, radioApiSlug;

  Radio({
    required this.radioTitle,
    required this.radioType,
    required this.radioFreq,
    required this.radioWebSlug,
    this.radioHlsSlug,
    this.radioApiSlug,
  });
}
// (val radioTitle: String, val radioFreq: String, val radioType: String, val radioWebSlug: String, val radioHlsSlug: String?, val radioApiSlug: String?) {
// }

class RadioList {
  static final List<Radio> radioList = [
    Radio(
      radioTitle: "KBS 제1라디오",
      radioType: "KBS",
      radioFreq: "FM 97.3㎒",
      radioWebSlug:
          "http://onair.kbs.co.kr/index.html?sname=onair&stype=live&ch_code=21#refresh",
      radioApiSlug:
          "https://cfpwwwapi.kbs.co.kr/api/v1/landing/live/channel_code/21/",
    ),
    Radio(
      radioTitle: "KBS 제2라디오",
      radioType: "KBS",
      radioFreq: "FM 106.1㎒",
      radioWebSlug:
          "http://onair.kbs.co.kr/index.html?sname=onair&stype=live&ch_code=22#refresh",
      radioApiSlug:
          "https://cfpwwwapi.kbs.co.kr/api/v1/landing/live/channel_code/22/",
    ),
    Radio(
      radioTitle: "KBS 1FM",
      radioType: "KBS",
      radioFreq: "FM 93.1㎒",
      radioWebSlug:
          "http://onair.kbs.co.kr/index.html?sname=onair&stype=live&ch_code=24#refresh",
      radioApiSlug:
          "https://cfpwwwapi.kbs.co.kr/api/v1/landing/live/channel_code/24/",
    ),
    Radio(
      radioTitle: "KBS 2FM",
      radioType: "KBS",
      radioFreq: "FM 89.1㎒",
      radioWebSlug:
          "http://onair.kbs.co.kr/index.html?sname=onair&stype=live&ch_code=25#refresh",
      radioApiSlug:
          "https://cfpwwwapi.kbs.co.kr/api/v1/landing/live/channel_code/25/",
    ),
    Radio(
      radioTitle: "MBC 라디오",
      radioType: "MBC",
      radioFreq: "FM 95.9㎒",
      radioWebSlug: "http://mini.imbc.com/webapp_v3/mini.html?channel=sfm",
      radioHlsSlug:
          "http://miniplay.imbc.com/WebHLS.ashx?channel=sfm&protocol=M3U8",
    ),
    Radio(
      radioTitle: "MBC FM4U",
      radioType: "MBC",
      radioFreq: "FM 91.9㎒",
      radioWebSlug: "http://mini.imbc.com/webapp_v3/mini.html?channel=mfm",
      radioHlsSlug:
          "http://miniplay.imbc.com/WebHLS.ashx?channel=mfm&protocol=M3U8",
    ),
    Radio(
      radioTitle: "SBS 러브FM",
      radioType: "SBS",
      radioFreq: "FM 103.5㎒",
      radioWebSlug: "http://play.sbs.co.kr/onair/pc/index.html?id=S08",
      radioHlsSlug: null,
      radioApiSlug:
          "http://apis.sbs.co.kr/play-api/1.0/onair/channel/S08?protocol=hls",
    ),
    Radio(
      radioTitle: "SBS 파워FM",
      radioType: "SBS",
      radioFreq: "FM 107.7㎒",
      radioWebSlug: "http://play.sbs.co.kr/onair/pc/index.html?id=S07",
      radioHlsSlug: null,
      radioApiSlug:
          "http://apis.sbs.co.kr/play-api/1.0/onair/channel/S07?protocol=hls",
    ),
    Radio(
      radioTitle: "CBS 음악FM",
      radioType: "CBS",
      radioFreq: "FM 93.9㎒",
      radioWebSlug: "http://www.cbs.co.kr/radio/frame/AodJwPlayer.asp#refresh",
      radioHlsSlug:
          "http://aac.cbs.co.kr/cbs939/definst/cbs939.stream/playlist.m3u8",
      radioApiSlug: null,
    ),
    Radio(
      radioTitle: "CBS 표준FM",
      radioType: "CBS",
      radioFreq: "FM 98.1㎒",
      radioWebSlug: "http://www.cbs.co.kr/radio/frame/AodJwPlayer.asp",
      radioHlsSlug:
          "http://aac.cbs.co.kr/cbs981/definst/cbs981.stream/playlist.m3u8",
      radioApiSlug: null,
    ),
    Radio(
      radioTitle: "TBS 교통방송",
      radioType: "TBS",
      radioFreq: "FM 95.1㎒",
      radioWebSlug: "http://tbs.seoul.kr/player/live.do?channelCode=CH_A",
      radioHlsSlug: "http://58.234.158.60:1935/fmlive/myStream/playlist.m3u8",
      radioApiSlug: null,
    ),
// Radio(
// radioTitle: "TBS eFM",
// radioType: "TBS",
// radioFreq: "FM 101.3㎒",
// radioWebSlug: "http://tbs.seoul.kr/player/live.do?channelCode=CH_E",
// radioHlsSlug: "http://58.234.158.60:1935/efmlive/myStream/playlist.m3u8",
// radioApiSlug: null,
// ),
    Radio(
      radioTitle: "EBS FM 교육방송",
      radioType: "EBS",
      radioFreq: "FM 104.5㎒",
      radioWebSlug: "http://www.ebs.co.kr/radio/home?mainTop",
      radioHlsSlug:
          "http://ebsonair.ebs.co.kr/fmradiofamilypc/familypc1m/playlist.m3u8",
      radioApiSlug: null,
    ),
  ];
}
