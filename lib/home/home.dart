import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_proxy_worker/home/count_demo.dart';
import 'package:http_proxy_worker/home/device_info_state.dart';
import 'package:http_proxy_worker/home/models/device_info_models.dart';
import 'package:http_proxy_worker/service/api_service.dart';

final countProvider =
    StateNotifierProvider<CounterDemo, int>((ref) => CounterDemo());
final deviceInfo = StateNotifierProvider<DeviceInfoState, DeviceInfoModels>(
    (ref) => DeviceInfoState());

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            const Text(
              "SessionId: ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Text(
              "Request Number: 0",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const Text(
              "Handle Number: 0",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white12)),
              onPressed: () {
                var data = ApiService.shared.proxyClient();
                //ref.read(deviceInfo.notifier).updateState();
                // ApiService.shared.proxyClient();
              },
              child: const Text("Update Info"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ref.read(counterProvider.notifier).state++;
          // ref.read(counterProvider.notifier).update((state) => state + 1);
          // ref.read(countProvider.notifier).increment();
          ApiService.shared.getPingServer();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
