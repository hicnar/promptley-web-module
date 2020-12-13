import 'dart:async';

import '../web_request_handler.dart';

class SeekSliderHandler extends WebRequestHandler {

  static SeekSliderHandler _instance;
  SeekSliderHandler._();

  factory SeekSliderHandler() => _instance ?? (_instance = SeekSliderHandler._());

  @override
  FutureOr<dynamic> doPost(req, res) async {
    await req.parseBody();
    final speedDyn = req.bodyAsMap['speed'];
    print('SeekSlider received: $speedDyn');
    res.statusCode = 200;
    return {};
  }
}