import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/features/controller/auth_controller.dart';
import 'package:reddit_clone/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.profilePic),
            radius: 70,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'u/${user.name}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          ListTile(
            title: Text('My Profile'),
            leading: Icon(Icons.person),
            onTap: () => navigateToUserProfile(context, user.uid),
          ),
          ListTile(
            title: Text('Log Out'),
            leading: Icon(Icons.logout, color: Pallete.redColor),
            onTap: () => logOut(ref),
          ),
          //platform ui
          Switch.adaptive(value: true, onChanged: (val) {})
        ],
      )),
    );
  }
}
