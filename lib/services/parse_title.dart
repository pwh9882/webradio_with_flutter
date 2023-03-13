import 'dart:convert';

import 'package:cp949_codec/cp949_codec.dart';
import 'package:http/http.dart' as http;

import 'package:webradio_with_flutter/models/radio_channel.dart';

Future<String> parseTitle(RadioChannel radio) async {
  var titleText = '리스트에서 선택해주세요';
  http.Response response;
  switch (radio.radioType) {
    case "SBS":
      response = await http.get(Uri.parse(radio.radioApiSlug!));
      if (response.statusCode == 200) {
        var jObject = jsonDecode(response.body);
        titleText = jObject["onair"]["info"]["title"].toString();
      }
      break;

    case "KBS":
      response = await http.get(
        Uri.parse(
          "http://static.api.kbs.co.kr/mediafactory/v1/schedule/onair_now?rtype=jsonp&channel_code=21,22,24,25&local_station_code=00&callback=getChannelInfoList",
        ),
      );
      if (response.statusCode == 200) {
        var jsonText = response.body;
        jsonText = jsonText.substring(
          jsonText.indexOf("(") + 1,
          jsonText.indexOf(');'),
        );
        var jObject = jsonDecode(jsonText);
        titleText = jObject[RadioChannelList.radioList.indexOf(radio)]
                ["schedules"][0]["program_title"]
            .toString();
      }
      break;

    case "MBC":
      var url = RadioChannelList.radioList.indexOf(radio) == 4
          ? "http://control.imbc.com/Schedule/Radio/Time?sType=FM"
          : "http://control.imbc.com/Schedule/Radio/Time?sType=FM4U";
      response = await http.get(
        Uri.parse(url),
      );
      var jObject = json.decode(response.body);
      titleText = jObject[0]["Title"].toString();
      break;

    case "CBS":
      var url = RadioChannelList.radioList.indexOf(radio) == 8
          ? "http://www.cbs.co.kr/cbsplayer/rainbow/widget/timetable.asp?ch=2"
          : "http://www.cbs.co.kr/cbsplayer/rainbow/widget/timetable.asp?ch=4";
      response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'text/html; Charset=ks_c_5601-1987'},
      );
      var localDate = DateTime.now().hour * 3600 +
          DateTime.now().minute * 60 +
          DateTime.now().second;
      // 사이트가 구식이라 디코딩을 cp949를 이용해야함.
      var aspText = cp949.decode(response.bodyBytes);
      // aspText.replaceAll("	", " ");
      // print(aspText);
      // 별에 별 공백문자가 다 들어있어서 그냥 못 split함.
      var textList = aspText.split(RegExp(r'\s+'));
      // print(textList);
      // for (var text in textList) {
      //   print(text);
      // }

      var start = int.parse(textList[0]);
      var end = int.parse(textList[1]);
      var endIndex = 1;
      for (var i = 2; i < textList.length; i++) {
        if (localDate >= start && localDate < end + 1) {
          titleText = textList[endIndex + 2];
          break;
        }
        if (start == end) {
          end = int.parse(textList[i - 1]);
        }
        if (textList[i] == end.toString()) {
          start = end;
          endIndex = i + 1;
        }
      }
      for (var i = endIndex + 3; i < textList.length; i++) {
        if (textList[i].startsWith("http")) {
          break;
        } else if (textList[i].startsWith("/sermon/")) {
          break;
        }
        titleText += " ${textList[i]}";
      }
      // print("LOCALDATE:: $localDate");
      break;

    case 'TBS':
      var response = await http.get(Uri.parse(radio.radioWebSlug), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'User-Agent':
            'Mozilla/5.0 (Linux; U; Android 4.0.3; de-ch; HTC Sensation Build/IML74K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30'
      });

      if (response.statusCode == 200) {
        // '<span class="tit">'.length == 17;
        var title = response.body.substring(
            response.body.indexOf('class="tit">') + 'class="tit">'.length);
        title = title.substring(0, title.indexOf('</'));
        titleText = title;
      }

      break;

    case 'EBS':
      // TODO: 확실치 않음. 일단 제목 불러오기는 함.
      var response = await http.get(
          Uri.parse(
              'https://www.ebs.co.kr/onair/cururentOnair.json?channelCd=RADIO'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'User-Agent':
                'Mozilla/5.0 (Linux; U; Android 4.0.3; de-ch; HTC Sensation Build/IML74K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30'
          });

      if (response.statusCode == 200) {
        var jsonText = response.body;
        var jObject = json.decode(jsonText)['nowProgram'];
        titleText = jObject['title'].toString();
      }

      break;
  }
  // print(titleText);
  return titleText;
}
