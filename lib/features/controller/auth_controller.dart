import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/uitils.dart';
import 'package:reddit_clone/features/repository/auth_repository.dart';

import '../../models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

//instead of this code
// AuthController authController = AuthController();
// authController.signInWithGoogle();
// using this code
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    ref: ref,
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

//stateNotifier will inform to ui so that it can changed the loading state ui
class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        //loading state
        super(false);

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    //catch error l:failure , r:success
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }
}
