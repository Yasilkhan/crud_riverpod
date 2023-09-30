import 'package:crud_riverpod/features/rpository/userSignInRepository/userSignInRepository.dart';
import 'package:crud_riverpod/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final userSignInControllerProvider = Provider((ref) =>UserSignInController(userSignInRepository: ref.read(UserSignInRepositoryProvider)));

class UserSignInController{
final  UserSignInRepository _userSignInRepository;

UserSignInController({
  required UserSignInRepository userSignInRepository
}):_userSignInRepository=userSignInRepository;

UserModel newUserSignIn(String email,String password ){
  _userSignInRepository.newUserSignIn(email, password);

  return UserModel(email: email, password: password);
}
loginOnUser(String email,String password){
  _userSignInRepository.loginOnUser(email, password);

}
}