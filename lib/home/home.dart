import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_proxy_worker/home/count_demo.dart';
import 'package:http_proxy_worker/service/api_service.dart';

final countProvider =
    StateNotifierProvider<CounterDemo, int>((ref) => CounterDemo());

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
          'APP',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.refresh(countProvider);
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Center(child: Text(counter.toString() ?? "")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ref.read(counterProvider.notifier).state++;
          // ref.read(counterProvider.notifier).update((state) => state + 1);
          // ref.read(countProvider.notifier).increment();
          ApiService.shared.proxyClient();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
