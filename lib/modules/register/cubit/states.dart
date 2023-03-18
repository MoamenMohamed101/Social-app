abstract class SocialRegisterStates {}

class SocialRegisterInitialStates extends SocialRegisterStates {}

class SocialRegisterLoadingStates extends SocialRegisterStates {}

class SocialRegisterSuccessStates extends SocialRegisterStates {}

class SocialRegisterErrorStates extends SocialRegisterStates {
  final error;

  SocialRegisterErrorStates(this.error);
}
class SocialCreateUserSuccessStates extends SocialRegisterStates {

}

class SocialCreateUserErrorStates extends SocialRegisterStates {
  final error;

  SocialCreateUserErrorStates(this.error);
}
