import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error_text.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/core/uitils.dart';
import 'package:reddit_clone/features/controller/auth_controller.dart';
import 'package:reddit_clone/theme/pallete.dart';

import '../../community/controller/community_controller.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String uid;
  const UserProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  File? bannerFile;
  File? profileFile;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(userProvider)?.name);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  // void save(User user) {
  //   ref.read(userCommunityProvider.notifier).editCommunity(
  //         profileFile: profileFile,
  //         bannerFile: bannerFile,
  //         community: community,
  //         context: context,
  //       );
  // }

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(uid)).when(
          data: (community) => NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 150,
                      floating: true,
                      snap: true,
                      flexibleSpace: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(community.banner,
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(16),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate([
                        Align(
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(community.avatar),
                            radius: 35,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'r/${community.name}',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            community.mods.contains(user.uid)
                                ? OutlinedButton(
                                    onPressed: () {
                                      // navigateToModTools(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25),
                                    ),
                                    child: Text('Mod Tools'),
                                  )
                                : OutlinedButton(
                                    onPressed: () =>
                                        joinCommunity(ref, community, context),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25),
                                    ),
                                    child: Text(
                                        community.members.contains(user.uid)
                                            ? 'Joined'
                                            : 'Join'),
                                  ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('${community.members.length} members'),
                        ),
                      ])),
                    ),
                  ];
                },
                body: Text('Displaying posts'),
              ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => Loader()),
    );
  }
}
