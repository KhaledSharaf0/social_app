abstract class SocialState{}

class SocialInitialState extends SocialState{}
class SocialLoadingState extends SocialState{}
class SocialGetUserDataSuccessState extends SocialState{}
class SocialGetUserDataErrorState extends SocialState{
  final String error;
  SocialGetUserDataErrorState (this.error);
}

