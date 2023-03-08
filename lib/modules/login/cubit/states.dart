abstract class SocialLoginStates {}

class SocialLoginInitialStates extends SocialLoginStates {}

class SocialLoginLoadingStates extends SocialLoginStates {}

class SocialLoginSuccessStates extends SocialLoginStates {}

class SocialLoginErrorStates extends SocialLoginStates {
  final error;

  SocialLoginErrorStates(this.error);
}