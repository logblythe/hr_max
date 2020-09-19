import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmax/network/api_exceptions.dart';
import 'package:hrmax/network/response.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isDisposed = false;
  Status status;
  String _error;
  dynamic _dialogContent;

  get dialogContent => _dialogContent;

  get error => _error;

  get loading => status == Status.LOADING;

  setLoading() {
    status = Status.LOADING;
    if (!_isDisposed) notifyListeners();
  }

  setPaginating() {
    status = Status.PAGINATING;
    if (!_isDisposed) notifyListeners();
  }

  setCompleted() {
    status = Status.COMPLETED;
    if (!_isDisposed) notifyListeners();
  }

  setError(error) {
    if (error is AppException) {
      _error = error.toJson()['Message'] ?? error.toJson()['message'];
    } else {
      _error = error.toString();
    }
    status = Status.ERROR;
    if (!_isDisposed) {
      notifyListeners();
      Fluttertoast.showToast(
          msg: _error,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  showToast(message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
