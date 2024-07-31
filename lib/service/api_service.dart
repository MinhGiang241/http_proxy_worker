// ignore_for_file: avoid_print

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
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
    print('Running on ${androidInfo?.model}'); // e.g. "Moto G (4)"
    if (Platform.isIOS) {
      iosInfo = await deviceInfo?.iosInfo;
    }
    print('Running on ${iosInfo?.utsname.machine}'); // e.g. "iPod7,1"
    return {deviceInfo, androidInfo, iosInfo};
  }

  getPingServer() async {
    try {
      final results = await dio.get(pingUrl);
      var res = APIResult.fromMap(results.data);
      pingCommand = PingDtos.fromMap(res.data).command;
      return results;
    } catch (e) {
      return;
    }
  }

  proxyClient() async {
    try {
      final results = await dio.post(initUrl, data: {
        "name": "Giang",
        "lastIp": "111.111.11",
        "sessionId": sessionId,
        "osPlatform": Platform.isIOS
            ? 'Ios'
            : Platform.isAndroid
                ? "Android"
                : ""
      });
      var res = APIResult.fromMap(results.data);
      return res.data;
    } catch (e) {
      return (APIResult(
        code: 1,
        message: "Có lỗi xảy ra",
      ));
    }
  }
}
