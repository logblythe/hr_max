import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hrmax/app/dialog_request.dart';
import 'package:hrmax/app/dialog_response.dart';
import 'package:hrmax/core/services/navigation_service.dart';
import 'package:hrmax/ui/widgets/button.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DialogService {
  Completer<DialogResponse> _dialogCompleter;
  DialogRequest _dialogRequest;

  Future<DialogResponse> showDialog2({
    String title,
    String description,
    String buttonTitlePositive,
    String buttonTitleNegative,
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _dialogRequest = DialogRequest(
      title: title,
      description: description,
      buttonTitlePositive: buttonTitlePositive,
      buttonTitleNegative: buttonTitleNegative,
    );
    showDialog(
        context: navigatorKey.currentState.overlay.context,
        builder: (context) {
          return AlertDialog(
            title: Text(_dialogRequest.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Theme.of(context).primaryColorDark)),
            content: Text(
              _dialogRequest.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            actions: [
              _dialogRequest.buttonTitleNegative != null
                  ? InkWell(
                      onTap: () {
                        dialogComplete(DialogResponse(rejected: true));
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_dialogRequest.buttonTitleNegative),
                      ),
                    )
                  : Container(),
              SizedBox(
                width: 64,
                child: Button(
                  label: _dialogRequest.buttonTitlePositive ?? "OK",
                  onPressed: () {
                    dialogComplete(DialogResponse(confirmed: true));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
    return _dialogCompleter.future;
  }

  void dialogComplete(DialogResponse dialogResponse) {
    _dialogCompleter.complete(dialogResponse);
    _dialogCompleter = null;
  }
}
