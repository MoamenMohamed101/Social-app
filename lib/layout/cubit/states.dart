abstract class SocialStates {}

class SocialInitialStates extends SocialStates {}

class SocialGetUserLoadingStates extends SocialStates {}

class SocialGetUserSuccessStates extends SocialStates {}

class SocialGetUserErrorStates extends SocialStates {
  final String? error;

  SocialGetUserErrorStates(this.error);
}

class SocialGetPostsLoadingStates extends SocialStates {}

class SocialGetPostsSuccessStates extends SocialStates {}

class SocialGetPostsErrorStates extends SocialStates {
  final String? error;

  SocialGetPostsErrorStates(this.error);
}

class SocialLikePostSuccessStates extends SocialStates {}

class SocialLikePostErrorStates extends SocialStates {
  final String? error;

  SocialLikePostErrorStates(this.error);
}

class SocialChangeBottomNav extends SocialStates {}

class SocialNewPost extends SocialStates {}

class SocialProfileImagePickedSuccessStates extends SocialStates {}

class SocialProfileImagePickedErrorStates extends SocialStates {}

class SocialCoverImagePickedSuccessStates extends SocialStates {}

class SocialCoverImagePickedErrorStates extends SocialStates {}

class SocialUploadProfileImageSuccessStates extends SocialStates {}

class SocialUploadProfileImageErrorStates extends SocialStates {}

class SocialUploadCoverImageSuccessStates extends SocialStates {}

class SocialUploadCoverImageErrorStates extends SocialStates {}

class SocialUserUpdateErrorStates extends SocialStates {}

class SocialUserUpdateLoadingStates extends SocialStates {}

// create post
class SocialCreatePostErrorStates extends SocialStates {}

class SocialCreatePostLoadingStates extends SocialStates {}

class SocialCreatePostSuccessStates extends SocialStates {}

class SocialCreateImagePickedSuccessStates extends SocialStates {}

class SocialRemovePostImageSuccessStates extends SocialStates {}

class SocialCreateImagePickedErrorStates extends SocialStates {}

class SocialSignOutSuccessStates extends SocialStates {}

class SocialSignOutErrorStates extends SocialStates {}
