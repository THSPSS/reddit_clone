import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          leading: Icon(Icons.menu),
          actions: [
            Icon(Icons.search),
            Text('My Page'),
          ],
        ),
        body: Center(
          child: Text(user.karma.toString()),
        ));
  }
}
