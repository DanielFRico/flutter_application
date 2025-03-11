import 'package:namer_app/app/login/domain/repository/login_repository.dart';
import 'package:namer_app/app/login/presentation/model/login_form_model.dart';

class LoginUseCase {
  late final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository}) {}

  Future<bool> invoke(LoginFormModel loginFormModel) async {
    final data = loginFormModel.toEntity();
    return await loginRepository.login(data);
  }
}
