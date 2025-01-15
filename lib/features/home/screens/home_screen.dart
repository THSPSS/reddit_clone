import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/features/home/drawaers/community_list_drawer.dart';

import '../../controller/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Home'),
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () => displayDrawer(context),
              icon: Icon(Icons.menu),
            );
          }),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
            )
          ],
        ),
        drawer: CommunityListDrawer(),
        body: Center(
          child: Text(user.karma.toString()),
        ));
  }
}
