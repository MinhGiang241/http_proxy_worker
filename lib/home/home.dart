import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_proxy_worker/home/count_demo.dart';
import 'package:http_proxy_worker/home/device_info_state.dart';
import 'package:http_proxy_worker/home/models/device_info_models.dart';
import 'package:http_proxy_worker/service/api_service.dart';

final countProvider =
    StateNotifierProvider<CounterDemo, int>((ref) => CounterDemo());
final deviceInfoProvider =
    StateNotifierProvider<DeviceInfoState, DeviceInfoModels>(
        (ref) => DeviceInfoState());

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dev = ref.watch(deviceInfoProvider);
    final counter = ref.watch(countProvider);
    ref.listen(countProvider, (previous, next) {
      if (next == 10) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('The value is $next')));
      }
    });
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            textBaseline: TextBaseline.ideographic),
        backgroundColor: Colors.blue,
        title: const Text(
          'HTTP PROXY WORKER',
          textAlign: TextAlign.center,
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         ref.refresh(countProvider);
        //       },
        //       icon: Icon(Icons.refresh))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Device Info",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Text('Your node information',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
            Text(
              "SessionId: ${dev.httpInfo?.sessionId}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              "Request Number: ${dev.httpInfo?.primaryTimeout ?? '0'}",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const Text(
              "Handle Number: 0",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white12)),
                onPressed: () async {
                  var dataW = await ApiService.shared.proxyClient({
                    "name": Platform.isIOS
                        ? dev.iosInfo?.name ?? 'Unknown'
                        : Platform.isAndroid
                            ? dev.androidInfo?.model ?? 'Unknown'
                            : "",
                    "lastIp": '',
                    "sessionId": dev.httpInfo?.sessionId,
                    "osPlatform": Platform.isIOS
                        ? 'Ios'
                        : Platform.isAndroid
                            ? "Android"
                            : ""
                  }, context);
                  var dataJson = APIResult.fromMap(dataW);

                  if (dataJson.code != 0) {
                    showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        barrierDismissible: true,
                        builder: (ctx) => AlertDialog(
                              title: const Text("Có lỗi xảy ra"),
                              content: Text(dataJson.message ?? ""),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Đóng"))
                              ],
                            ));
                    return;
                  }
                  var deviceInfo = DeviceInfoModels.init();
                  deviceInfo.fromApi();
                  deviceInfo.updateHttpInfo(dataJson.data);
                  ref.read(deviceInfoProvider.notifier).updateState(deviceInfo);
                  // ApiService.shared.proxyClient();
                },
                child: const Text("Update Info"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res =
              await ApiService.shared.getPingServer(dev.httpInfo?.sessionId);
          var resJson = APIResult.fromMap(res);
          if (resJson.code != 0) {
            return;
          }
          var deviceInfo = DeviceInfoModels.init();
          deviceInfo.fromApi();
          deviceInfo.updatePingCommand(resJson.data);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
