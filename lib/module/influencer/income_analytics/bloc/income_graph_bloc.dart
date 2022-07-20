import 'package:app/module/influencer/dashboard/model/chart.dart';
import 'package:app/module/influencer/income_analytics/bloc/income_graph_event.dart';
import 'package:app/module/influencer/income_analytics/repo/income_graph_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'income_graph_state.dart';

class IncomeGraphBloc extends Bloc<IncomeGraphEvent, IncomeGraphState> {
  final IncomeGraphRepo _incomeGraphRepo;

  IncomeGraphBloc(this._incomeGraphRepo) : super(IncomeGraphLoadingState()) {
    on<IncomeGraphLoadingEvent>((event, emit) => emit((IncomeGraphLoadingState())));

    on<IncomeGraphLoadedEvent>((event, emit) {
            List<ChartData> incomeGraphFrontData = [];
            incomeGraphFrontData = _incomeGraphRepo.getIncomeGraphData();
            emit(IncomeGraphLoadedState(incomeGraphFrontData));
        },
    );
  }
}
