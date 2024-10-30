import 'package:loggy/loggy.dart';
import 'package:pathfinding/constants/strings.dart';

abstract class Validate {
  static String? uriValidation(String? value) {
    if (value?.isEmpty ?? true) {
      return Strings.uriEmptyError;
    }
    if(!(Uri.tryParse(value!)?.hasAbsolutePath ?? false)) {
      logInfo(Uri.tryParse(value));
      return Strings.wrongUriError;
    }
    return null;
  }
}
