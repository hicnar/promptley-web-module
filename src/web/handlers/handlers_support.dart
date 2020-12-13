import 'api/button_handler.dart' as api;
import 'api/seek_slider_handler.dart' as api;
import 'api/speed_slider_handler.dart' as api;
import 'web_request_handler.dart';
import 'www/home_handler.dart' as www;
import 'www/remote_handler.dart' as www;

mixin HandlersSupport {

  /// api handler instances
  static final _buttonApi = api.ButtonHandler();
  static final _seekSliderApi = api.SeekSliderHandler();
  static final _speedSliderApi = api.SpeedSliderHandler();

  /// www handler instances
  static final _home = www.HomeHandler();
  static final _remote = www.RemoteHandler();

  /// api handlers
  WebRequestHandler buttonApi = _buttonApi;
  WebRequestHandler seekSliderApi = _seekSliderApi;
  WebRequestHandler speedSliderApi = _speedSliderApi;

  /// web handlers
  WebRequestHandler homeWww = _home;
  WebRequestHandler remoteWww = _remote;
}