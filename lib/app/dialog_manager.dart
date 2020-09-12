import 'package:flutter/material.dart';
import 'package:hrmax/app/dialog_request.dart';
import 'package:hrmax/app/dialog_response.dart';
import 'package:hrmax/core/services/dialog_service.dart';
import 'package:hrmax/ui/widgets/button.dart';

import 'locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest dialogRequest) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(dialogRequest.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Theme.of(context).primaryColorDark)),
            content: Text(
              dialogRequest.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            actions: [
              dialogRequest.buttonTitleNegative != null
                  ? InkWell(
                      onTap: () {
                        _dialogService
                            .dialogComplete(DialogResponse(rejected: true));
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(dialogRequest.buttonTitleNegative),
                      ),
                    )
                  : Container(),
              SizedBox(
                width: 64,
                child: Button(
                  label: dialogRequest.buttonTitlePositive ?? "OK",
                  onPressed: () {
                    _dialogService
                        .dialogComplete(DialogResponse(confirmed: true));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
  }
}
