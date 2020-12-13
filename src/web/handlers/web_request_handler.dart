import 'dart:async';

import 'package:angel_framework/angel_framework.dart';

abstract class WebRequestHandler{
  FutureOr<dynamic> doGet(RequestContext req, ResponseContext res) =>
    throw AngelHttpException.notImplemented();

  FutureOr<dynamic> doPost(RequestContext req, ResponseContext res) =>
    throw AngelHttpException.notImplemented();

  FutureOr<dynamic> doDelete(RequestContext req, ResponseContext res) =>
    throw AngelHttpException.notImplemented();

  FutureOr<dynamic> doPut(RequestContext req, ResponseContext res) =>
    throw AngelHttpException.notImplemented();

  FutureOr<dynamic> doPatch(RequestContext req, ResponseContext res) =>
    throw AngelHttpException.notImplemented();
}