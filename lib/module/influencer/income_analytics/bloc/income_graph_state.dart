part of 'income_graph_bloc.dart';

abstract class IncomeGraphState extends Equatable {
  const IncomeGraphState();

  @override
  List<Object> get props => [];
}

class IncomeGraphLoadingState extends IncomeGraphState{}

class IncomeGraphLoadedState extends IncomeGraphState{
  final List<ChartData> _incomeGraphFrontData;
  const IncomeGraphLoadedState(this._incomeGraphFrontData);

  List<ChartData> get getIncomeGraphData => _incomeGraphFrontData;
}

class IncomeGraphErrorState extends IncomeGraphState{}