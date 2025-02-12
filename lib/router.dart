import 'package:flutter/material.dart';
import 'package:reddit_clone/features/community/screen/add_mods_screen.dart';
import 'package:reddit_clone/features/community/screen/create_community_screen.dart';
import 'package:reddit_clone/features/community/screen/edit_community_screen.dart';
import 'package:reddit_clone/features/community/screen/mode_tools_screen.dart';
import 'package:reddit_clone/features/home/screens/home_screen.dart';
import 'package:reddit_clone/features/screens/login_screen.dart';
import 'package:reddit_clone/features/user_profile/screens/user_profile_screen.dart';
import 'package:routemaster/routemaster.dart';

import 'features/community/screen/community_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) => MaterialPage(
        child: CreateCommunityScreen(),
      ),
  '/r/:name': (route) => MaterialPage(
        child: CommunityScreen(name: route.pathParameters['name']!),
      ),
  '/mod-tools/:name': (routeData) => MaterialPage(
        child: ModToolsScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/edit-community/:name': (routeData) => MaterialPage(
        child: EditCommunityScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/add-mods/:name': (routeData) => MaterialPage(
        child: AddModsScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  'u/:uid': (routeData) => MaterialPage(
        child: UserProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
});
