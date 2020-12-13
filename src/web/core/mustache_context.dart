import 'package:file/file.dart';

import 'package:mustache_template/mustache_template.dart';

class MustacheContext {

  static MustacheContext _instance;

  final FileSystem _fs;
  final String _viewsDir;
  final String _partsDir;
  final String _extension;


  MustacheContext._create(
    FileSystem fs,
    String viewsDir,
    String partsDir,
    String extension) :
      _fs = fs,
      _viewsDir = viewsDir,
      _partsDir = partsDir,
      _extension = extension;
  
  factory MustacheContext({
    FileSystem fs,
    String viewsDir,
    String partsDir,
    String extension}) {
    return _instance ?? (_instance =
      MustacheContext._create(fs, viewsDir, partsDir, extension)
    );
  }

  Template resolveView(String viewName, PartialResolver resolver) {
    final viewPath = _viewPath(viewName);
    return Template(
      _fs.file(viewPath).readAsStringSync(), name: viewPath,
      partialResolver: resolver, lenient: true
    );
  }

  Template resolvePart(String partName, PartialResolver resolver) {
    final partPath = _partPath(partName);
    return Template(
      _fs.file(partPath).readAsStringSync(), name: partPath,
      partialResolver: resolver, lenient: true
    );
  }
  
  String _viewPath(String viewName) => '$_viewsDir/$viewName$_extension';
  String _partPath(String partName) => '$_partsDir/$partName$_extension';
}
