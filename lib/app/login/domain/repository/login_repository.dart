import 'package:namer_app/app/login/domain/entity/login_entity.dart';

abstract class LoginRepository {
  Future<bool> login(LoginEntity loginEntity);
}
