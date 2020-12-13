import 'package:angel_framework/angel_framework.dart';
import 'package:file/file.dart';
import 'package:mustache_template/mustache.dart';

import 'mustache_context.dart';

mustache(FileSystem fs, {String viewsDir='web/views', String partsDir = 'parts', String fileExtension = '.mustache'}) {

  final context = MustacheContext(
    fs: fs,viewsDir: viewsDir, partsDir: '$viewsDir/$partsDir', extension: fileExtension
  );

  return (Angel app) {
    app.viewGenerator = (String name, [Map data]) {
      PartialResolver partialsProvider;
      partialsProvider = (name) => context.resolvePart(name, partialsProvider);
      final template = context.resolveView(name, partialsProvider);
      return template.renderString(data ?? {});
    };
  };
}