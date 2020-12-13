import 'dart:async';
import '../web_request_handler.dart';

class HomeHandler extends WebRequestHandler{

  static HomeHandler _instance;
  HomeHandler._();

  factory HomeHandler() => _instance ?? (_instance = HomeHandler._());

  @override
  FutureOr<dynamic> doGet(req, res) =>
    res.render('home', {
      'title' : "Tytuł",
      'appname': "Nazwa Aplikacji"
    });
}