import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_proxy_worker/home/models/device_info_models.dart';

class DeviceInfoState extends StateNotifier<DeviceInfoModels> {
  DeviceInfoState() : super(DeviceInfoModels.init());

  updateState(DeviceInfoModels info) {
    state = info;
  }
}
