import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class PermissionService {
  Future<bool> checkPermission(Permission permissionName) async {
    if (Platform.isAndroid) {
      PermissionStatus status = await permissionName.status;
      switch (status) {
        case PermissionStatus.undetermined:
          final result = await permissionName.request();
          if (result == PermissionStatus.granted) {
            return true;
          }else{
            return false;
          }
          break;
        case PermissionStatus.granted:
          return true;
          break;
        case PermissionStatus.denied:
          bool isShown = await Permission.contacts.shouldShowRequestRationale;
          return isShown;
          break;
        case PermissionStatus.restricted:
          // TODO: Handle this case.
          break;
        case PermissionStatus.permanentlyDenied:
          bool canOpen = await openAppSettings();
          print('canOpen $canOpen');
          break;
      }
      if (status != PermissionStatus.granted) {
        final result = await permissionName.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
}
