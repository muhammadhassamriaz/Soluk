part of 'challengesbloc_cubit.dart';

@immutable
abstract class ChallengesblocState {
  final ChallengesModal? challengeData;
  final bool? approveEmpty;
  final bool? disApproveEmpty;
  const ChallengesblocState({this.challengeData,this.approveEmpty=false,this.disApproveEmpty});
}

class ChallengesblocInitial extends ChallengesblocState {}
class ChallengesEmpty extends ChallengesblocState {
  const ChallengesEmpty():super();
}
class ChallengesLoading extends ChallengesblocState {
  const ChallengesLoading():super();
}
class ChallengesLoaded extends ChallengesblocState {
  const ChallengesLoaded({ChallengesModal? challengesModal,bool? approveEmpty,bool? disApproveEmpty}):super(challengeData: challengesModal,approveEmpty: approveEmpty,disApproveEmpty:disApproveEmpty );
}
