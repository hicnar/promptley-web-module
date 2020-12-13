import 'dart:async';

import '../web_request_handler.dart';

class ButtonHandler extends WebRequestHandler {

  static ButtonHandler _instance;

  ButtonHandler._();

  factory ButtonHandler() => _instance ?? (_instance = ButtonHandler._());

  @override
  FutureOr<dynamic> doPost(req, res) async {
    await req.parseBody();
    final actionDyn = req.bodyAsMap['action'];

    print('Button handler received: $actionDyn');
    res.statusCode = 200;
    return {};
  }
}