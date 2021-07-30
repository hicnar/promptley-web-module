import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:file/local.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logging/logging.dart';
import 'package:pretty_logging/pretty_logging.dart';

import 'core/mustache.dart';
import 'handlers/handlers_support.dart';

class AppServer with HandlersSupport {

  final _mimeMap = {
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'gif': 'image/gif',
    'tiff': 'image/tiff',
    'ico': 'image/vnd.microsoft.icon'
  };

  Angel _app;
  static AppServer _instance;

  AppServer._createInstance() {

    Logger.root.onRecord.listen(prettyLog);

    final fs = LocalFileSystem();

    _app = Angel(
      logger: Logger('angel'))
      ..configure(mustache(fs))
      ..group('', (web) {
        web..get(r'.*.js', (req, res) async {
          final content = await fs.file('web/js${req.uri.toString()}').readAsString();
          res..contentType = MediaType.parse('text/javascript')
             ..write(content);
        })
        ..get(r'.*.css', (req, res) async {
          final content = await fs.file('web/style${req.uri.toString()}').readAsString();
          res..contentType = MediaType.parse('text/css')
             ..write(content);
        })
        ..get(r'.*.jpg|.*.jpeg|.*.png|.*.gif|.*.tiff|.*.ico', (req, res) async {
          try {
            final uri = req.uri.toString();
            final imageFile = fs.file('web/images$uri');
            res..contentType = MediaType.parse(_mimeMap[uri.split('.').last])
               ..contentLength = await imageFile.length()
               ..add(await imageFile.readAsBytesSync());
          } catch (e) {
            res.statusCode = 404;
          }
        })
        ..group('', (pages) {
          pages
            ..group('/remote', (remote) {
              remote.get('', remoteWww.doGet);
            })
          ;
        }, middleware: [(req, res) {
          res.contentType = MediaType.parse('text/html');
        }]);
      })
      ..group('/api', (api) {
        api.group('/v1', (v1) {
          v1..group('/button', (button) {
            button.post('', buttonApi.doPost);
          })
          ..group('/sliders', (sliders) {
            sliders
             ..group('/seek', (seek) {
                 seek.post('', seekSliderApi.doPost);
             })
             ..group('/speed', (speed) {
                 speed.post('', speedSliderApi.doPost);
             });
          });
        });
    });
  }

  factory AppServer() => _instance ?? (_instance = AppServer._createInstance());

  FutureOr<Angel> get getApp async => _app;
}