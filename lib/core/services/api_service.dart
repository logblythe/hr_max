import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hrmax/core/services/storage_service.dart';
import 'package:hrmax/network/api_exceptions.dart';
import 'package:hrmax/network/logging_interceptor.dart';
import 'package:hrmax/network/models/login_res.dart';
import 'package:hrmax/network/token_refresh_policy.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class ApiService {
  // static final String baseUrl = "https://api.technomax.com.np/api";
  // static final String baseUrl = "https://elearning.megabank.com.np/api";

  final StorageService _storageService;
  String baseUrl;
  final client = HttpClientWithInterceptor.build(
    retryPolicy: ExpiredTokenRetryPolicy(),
    interceptors: [LoggingInterceptor()],
  );

  ApiService({@required StorageService storageService})
      : _storageService = storageService {
    initBaseUrl();
  }

  void initBaseUrl() async {
    String savedUrl = await _storageService.get(KEY_BASE_URL);
    if (savedUrl != null) {
      baseUrl = savedUrl + "api";
    }
  }

  Future<Map<String, String>> getHeaders() async {
    StorageService _storage = StorageService();
    return {
      "token": await _storage.get(KEY_TOKEN),
      "deviceId": await _storage.get(KEY_DEVICE_ID)
    };
  }

  Future<dynamic> refreshToken() async {
    StorageService _storage = StorageService();
    post("/account/userLogin", params: {
      "username": await _storage.get(KEY_USERNAME),
      "password": await _storage.get(KEY_PASSWORD),
      "deviceId": await _storage.get(KEY_DEVICE_ID),
    }).then(
      (value) {
        LoginRes _loginModel = LoginRes.fromJsonMap(value);
        _storage.set(KEY_TOKEN, value: _loginModel.userToken);
      },
    );
  }

  Future<dynamic> get(String url) async {
    initBaseUrl();
    var _headers = await getHeaders();
    try {
      var response = await client.get(baseUrl + url, headers: _headers);
      if (response.statusCode == 401) {
        await refreshToken();
        response = await post(url);
      }
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException({"message": "No internet connection"});
    }
  }

  Future<dynamic> post(String url, {Map<String, dynamic> params}) async {
    initBaseUrl();
    var _headers = await getHeaders();
    print('the params $params');
    try {
      var response = await client.post(
        baseUrl + url,
        headers: _headers,
        body: params,
      );
      if (response.statusCode == 401) {
        await refreshToken();
        response = await post(url, params: params);
      }
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException({"message": 'No Internet connection'});
    }
  }

  Future<dynamic> patch(String url, {Map<String, dynamic> params}) async {
    print('the params $params');
    var _headers = await getHeaders();
    var responseJson;
    try {
      final response = await client.patch(
        baseUrl + url,
        headers: _headers,
        body: params,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException({"message": 'No Internet connection'});
    }
    return responseJson;
  }

  Future<dynamic> multipart(String url, {Map<String, dynamic> params}) async {
    var responseJson;
    try {
      var _headers = await getHeaders();
      var request = http.MultipartRequest("PATCH", Uri.parse(baseUrl + url));
      request.headers
        ..addAll({HttpHeaders.contentTypeHeader: "multipart/form-data"})
        ..addAll(_headers);
      //add text fields
      request.fields["userId"] = params['userId'];
      String mimeType = lookupMimeType(params['image'].path);
      var fileType = mimeType.split('/');
      var pic = await http.MultipartFile.fromPath(
        "image",
        params['image'].path,
        contentType: MediaType(fileType[0], fileType[1]),
      );
      //add multipart to request
      request.files.add(pic);
      var streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException({"message": 'No Internet connection'});
    }
    return responseJson;
  }

  downloadCertificate(String url, int idTracker, int idTrackerHistory) async {
    StorageService _storage = StorageService();
    String userName = await _storage.get(KEY_USERNAME);
    var _headers = await getHeaders();
    String _localPath =
        (await _findLocalPath()) + Platform.pathSeparator + 'Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    FlutterDownloader.enqueue(
        url: baseUrl + url,
        headers: _headers,
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true,
        fileName: "${userName}_${idTracker}_$idTrackerHistory.pdf");
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(json.decode(response.body.toString()));
      case 401:
      case 403:
        throw UnauthorisedException(json.decode(response.body.toString()));
      case 404:
        throw NotFoundException({"message": "Requested url is not available"});
      case 500:
      default:
        throw FetchDataException({
          "message":
              'Error occurred while Communication with Server with StatusCode : ${response.statusCode}'
        });
    }
  }
}
