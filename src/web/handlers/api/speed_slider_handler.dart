import 'dart:async';

import '../web_request_handler.dart';

class SpeedSliderHandler extends WebRequestHandler {

  static SpeedSliderHandler _instance;

  SpeedSliderHandler._();

  factory SpeedSliderHandler() =>
      _instance ?? (_instance = SpeedSliderHandler._());

  @override
  FutureOr<dynamic> doPost(req, res) async {
    await req.parseBody();
    final speedDyn = req.bodyAsMap['speed'];
    print('SpeedSlider received: $speedDyn');
    res.statusCode = 200;
    return {};
  }

}