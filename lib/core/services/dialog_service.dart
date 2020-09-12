import 'dart:async';

import 'package:hrmax/app/dialog_request.dart';
import 'package:hrmax/app/dialog_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DialogService {
  Function(DialogRequest) _showDialogListener;
  Completer<DialogResponse> _dialogCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String buttonTitlePositive,
    String buttonTitleNegative,
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonTitlePositive: buttonTitlePositive,
      buttonTitleNegative: buttonTitleNegative,
    ));
    return _dialogCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse dialogResponse) {
    _dialogCompleter.complete(dialogResponse);
    _dialogCompleter = null;
  }
}
