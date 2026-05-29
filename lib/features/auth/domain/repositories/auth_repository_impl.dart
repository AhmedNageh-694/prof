import 'package:injectable/injectable.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return User(id: '1', email: email);
  }

  @override
  Future<User> signUp(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return User(id: '2', email: email);
  }
}
