import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error_text.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/core/uitils.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';
import 'package:reddit_clone/features/controller/auth_controller.dart';
import 'package:reddit_clone/theme/pallete.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final String uid;
  const EditProfileScreen({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  File? bannerFile;
  File? profileFile;

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
  Widget build(BuildContext context) {
    return ref.watch(getUserDataProvider(widget.uid)).when(
        data: (user) {
          return Scaffold(
              backgroundColor: Pallete.darkModeAppTheme.scaffoldBackgroundColor,
              appBar: AppBar(
                centerTitle: false,
                title: Text('Edit Profile'),
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Save'),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: selectBannerImage,
                            child: DottedBorder(
                              borderType: BorderType.Rect,
                              radius: Radius.circular(15),
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              color: Pallete.darkModeAppTheme.textTheme
                                  .bodyMedium!.color!,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: bannerFile != null
                                    ? Image.file(bannerFile!)
                                    : user.banner.isEmpty ||
                                            user.banner ==
                                                Constants.bannerDefault
                                        ? Center(
                                            child: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 40))
                                        : Image.network(user.banner),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: GestureDetector(
                              onTap: selectProfileImage,
                              child: profileFile != null
                                  ? CircleAvatar(
                                      backgroundImage: FileImage(profileFile!),
                                      radius: 32,
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(user.profilePic),
                                      radius: 32,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       filled: true,
                    //       hintText: 'Name',
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.blue),
                    //         borderRadius: BorderRadius.circular(10),
                    //       )),
                    // )
                  ],
                ),
              ));
        },
        error: (error, stackTarce) => ErrorText(error: error.toString()),
        loading: () => Loader());
  }
}
