import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error_text.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/features/controller/auth_controller.dart';
import 'package:reddit_clone/models/user_model.dart';
import 'package:reddit_clone/router.dart';
import 'package:routemaster/routemaster.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'theme/pallete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Pallete.darkModeAppTheme,
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (data != null) {
                getData(ref, data);
                if (userModel != null) {
                  return loggedInRoute;
                }
              }
              return loggedOutRoute;
            }),
            routeInformationParser: RoutemasterParser(),
          ),
          error: (error, s) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref.watch(authStateChangeProvider).when(
//           data: (data) => MaterialApp.router(
//             debugShowCheckedModeBanner: false,
//             title: 'Flutter Demo',
//             theme: Pallete.darkModeAppTheme,
//             routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
//               if (data != null) {
//                 return loggedInRoute;
//               } else {
//                 return loggedOutRoute;
//               }
//             }),
//             routeInformationParser: RoutemasterParser(),
//           ),
//           error: (error, s) => ErrorText(error: error.toString()),
//           loading: () => const Loader(),
//         );
//   }
// }
