import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class PermissionService{

  Future<bool> checkPermission(Permission permissionName) async {
    if (Platform.isAndroid) {
      final status = await permissionName.status;
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