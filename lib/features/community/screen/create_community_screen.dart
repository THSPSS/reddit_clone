import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';

import '../../../theme/pallete.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    communityNameController.dispose();
  }

  void createCommunity() {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(communityNameController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create a community'),
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Community name')),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: communityNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Pallete.greyColor,
                      border: InputBorder.none,
                      hintText: 'r/community_name',
                      contentPadding: EdgeInsets.all(15.0),
                    ),
                    maxLength: 21,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: createCommunity,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Pallete.blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Create a community',
                      style: TextStyle(
                        color: Pallete.whiteColor,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
