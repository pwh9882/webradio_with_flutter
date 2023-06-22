import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:webradio_with_flutter/models/radio_channel.dart';

Future<String> parseHlsSlugFromApiSlug(RadioChannel radio) async {
  var hlsSlug = "";
  final dio = Dio();
  // http.Response response = await http.get(
  //   Uri.parse(radio.radioApiSlug!),
  //   headers: {
  //     "Content-Type": "application/json;charset=UTF-8",
  //     "cache-control": "no-cache",
  //     "pragma": "no-cache",
  //     "User-Agent": "Mozilla"
  //   },
  // );
  // var jsonText = response.body;
  var response = await dio.get(radio.radioApiSlug!);
  // print(response.data);
  // print("\nn\\n\n\n\n\n\n\\n\n\n\n\n\n\n");

  var jsonText = response.data;
  // print(jsonText["channel_item"][0]["service_url"]);
  switch (radio.radioType) {
    case "SBS":
      hlsSlug =
          jsonDecode(jsonText)["onair"]["source"]["mediasource"]["mediaurl"];
      break;
    case "KBS":
      // print(1);
      hlsSlug = jsonText["channel_item"][0]["service_url"];
      // print(2);
      break;
    case "MBC":
      hlsSlug = jsonText;
      break;
  }
  // print(hlsSlug);
  return hlsSlug;
}
