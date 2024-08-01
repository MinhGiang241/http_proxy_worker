// ignore_for_file: avoid_print

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http_proxy_worker/home/models/device_info_models.dart';

class ApiService {
  ApiService() {
    getDeviceInfo();
  }
  final dio = Dio();
  DeviceInfoPlugin? deviceInfo;
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  int? secondPingSeq;
  String? sessionId;
  int? primaryTimeout;
  bool? sendResponseWithSecondary;
  String? pingCommand;

  final pingUrl =
      'https://api.cloud1.masflex.net/apimodel/proxyclient.ping?regCode=cloud1_masflex_net_metrics';
  final initUrl =
      'https://api.cloud1.masflex.net/apimodel/proxyclient.init?regCode=cloud1_masflex_net_metrics';

  static final shared = ApiService();

  getDeviceInfo() async {
    deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo?.androidInfo;
    }
    print('Running on ${androidInfo?.model}'); // e.g. "Moto G (2)"
    if (Platform.isIOS) {
      iosInfo = await deviceInfo?.iosInfo;
    }
    print('Running on ${iosInfo?.utsname.machine}'); // e.g. "iPod7,1"

    Map<String, dynamic> MAP = {
      "deviceInfo": deviceInfo,
      "androidInfo": androidInfo,
      "iosInfo": iosInfo
    };

    return MAP;
  }

  getPingServer(String? sessionId) async {
    try {
      final results = await dio.get(pingUrl,
          options: Options(headers: {"X-SESSION-ID": sessionId}));

      return results.data;
    } catch (e) {
      return;
    }
  }

  proxyClient(Map<String, dynamic> data, BuildContext context) async {
    try {
      final results = await dio.post(initUrl, data: data);
      var res = (results.data);
      return res;
    } catch (e) {
      return (APIResult(
        code: 1,
        message: "Có lỗi xảy ra",
      ));
    }
  }
}
