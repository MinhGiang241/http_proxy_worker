import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';

class APIResult {
  APIResult({this.code, this.data, this.message});
  int? code;
  String? message;
  dynamic data;
}

class ApiService {
  ApiService() {
    getDeviceInfo();
  }
  final dio = Dio();
  late DeviceInfoPlugin deviceInfo;
  late AndroidDeviceInfo androidInfo;
  late IosDeviceInfo iosInfo;

  static final shared = ApiService();

  getDeviceInfo() async {
    deviceInfo = DeviceInfoPlugin();
    androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"

    iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
  }

  final domain = 'https://api.cloud1.masflex.net/apimodel/proxyclient.init';

  getPingServer() async {
    try {
      print(this.deviceInfo);
      print(this.androidInfo);
      print(this.iosInfo);
      final result = await dio.get(domain);
    } catch (e) {
      return;
    }
  }

  proxyClient() async {
    try {
      final result = await dio.post(domain, data: {"name": "Giang"});

      print(result);
    } catch (e) {
      return (APIResult(
        code: 1,
        message: "Có lỗi xảy ra",
      ));
    }
  }
}
