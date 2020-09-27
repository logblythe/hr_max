import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:http_interceptor/models/retry_policy.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    /*  if (response.statusCode == 401) {
      _navigationService.removeAllAndNavigateTo(Routes.LoginRoute);
    }*/
    return false;
  }
}
