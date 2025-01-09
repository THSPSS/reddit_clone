import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/uitils.dart';
import 'package:reddit_clone/features/repository/auth_repository.dart';

//instead of this code
// AuthController authController = AuthController();
// authController.signInWithGoogle();

//Provider
final authControllerProvider = Provider(
  (ref) => AuthController(
    authRepository: ref.read(authRepositoryProvider),
  ),
);

class AuthController {
  final AuthRepository _authRepository;
  AuthController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  void signInWithGoogle(BuildContext context) async {
    final user = await _authRepository.signInWithGoogle();
    //catch error l:failure , r:success
    user.fold((l) => showSnackBar(context, l.message), (r) => null);
  }
}
