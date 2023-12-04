import '../../di/locator.dart';
import 'package:injectable/injectable.dart';
import '../di/configuration.config.dart';

@InjectableInit(
  initializerName: r'$configureDependencies',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() => $configureDependencies(locator);
