import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void signInWithGoogle() {
    _authRepository.signInWithGoogle();
  }
}
