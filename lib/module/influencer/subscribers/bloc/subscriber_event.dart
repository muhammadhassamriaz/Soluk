part of 'subscriber_bloc.dart';

abstract class SubscriberEvent extends Equatable {
  const SubscriberEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SubscribersListLoadingEvent extends SubscriberEvent{}

class SubscribersListLoadedEvent extends SubscriberEvent{}

class ErrorEvent extends SubscriberEvent{}


