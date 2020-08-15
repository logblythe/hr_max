
import 'package:flutter/material.dart';
import 'package:hrmax/core/enum/app_state.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isDisposed = false;
  AppState _appState = AppState.IDLE;

  bool get busy => _appState == AppState.BUSY;

  bool get error => _appState == AppState.ERROR;

  String _errorMessage;

  String get errorMessage => errorMessage;

  void setBusy(bool value) {
    _appState = value ? AppState.BUSY : AppState.IDLE;
    if (!_isDisposed) notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    _appState = AppState.ERROR;
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
