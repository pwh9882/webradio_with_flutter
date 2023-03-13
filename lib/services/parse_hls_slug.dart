import 'dart:convert';

import 'package:webradio_with_flutter/models/radio_channel.dart';

import 'package:http/http.dart' as http;

Future<String> parseHlsSlugFromApiSlug(RadioChannel radio) async {
  var hlsSlug = "";
  http.Response response = await http.get(
    Uri.parse(radio.radioApiSlug!),
    headers: {
      "Content-Type": "application/json;charset=UTF-8",
      "cache-control": "no-cache",
      "pragma": "no-cache",
      "User-Agent": "Mozilla"
    },
  );
  var jsonText = response.body;
  switch (radio.radioType) {
    case "SBS":
      hlsSlug =
          jsonDecode(jsonText)["onair"]["source"]["mediasource"]["mediaurl"];
      break;
    case "KBS":
      hlsSlug = jsonDecode(jsonText)["channel_item"][0]["service_url"];
      break;
    case "MBC":
      hlsSlug = jsonText;
      break;
  }
  return hlsSlug;
}
