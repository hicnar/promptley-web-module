
import 'dart:io';

import 'package:angel_hot/angel_hot.dart';

import 'web/app_server.dart';

void main(List<String> arguments) async {
  final hot = HotReloader(() => AppServer().getApp,
      [
        Directory('src'),
        Directory('web')
      ]
  );
  await hot.startServer('0.0.0.0', 7777);
}
