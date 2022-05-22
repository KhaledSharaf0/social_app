abstract class SocialRegisterState{}

class SocialRegisterInitialState extends SocialRegisterState{}
class SocialRegisterLoadingState extends SocialRegisterState{}
class SocialRegisterSuccessState extends SocialRegisterState{}
class SocialRegisterErrorState extends SocialRegisterState{
  final String error;
  SocialRegisterErrorState (this.error);
}


//Create New user in register
class SocialCreateSuccessState extends SocialRegisterState{}
class SocialCreateErrorState extends SocialRegisterState{
  final String error;
  SocialCreateErrorState (this.error);
}

class SocialChangePasswordVisibilityState extends SocialRegisterState{}