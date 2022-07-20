import 'package:equatable/equatable.dart';

abstract class IncomeGraphEvent extends Equatable {
  const IncomeGraphEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class IncomeGraphLoadingEvent extends IncomeGraphEvent{}

class IncomeGraphLoadedEvent extends IncomeGraphEvent{}

class IncomeGraphErrorEvent extends IncomeGraphEvent{}
