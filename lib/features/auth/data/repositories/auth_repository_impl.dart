import 'package:injectable/injectable.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login(String email, String password) async {
    if (email == 'test@test.com' && password == '123456') {
      return User(id: '1', email: email);
    }
    // Return success generally for demo purposes, or handle appropriately
    return User(id: '1', email: email);
  }

  @override
  Future<User> signUp(String email, String password) async {
    return User(id: '2', email: email);
  }
}
