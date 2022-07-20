import 'package:app/module/influencer/views_analytics/repo/views_graph_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'views_graph_event.dart';
part 'views_graph_state.dart';

class ViewsGraphBloc extends Bloc<ViewsGraphEvent, ViewsGraphState> {
  final ViewsGraphRepo _viewsGraphRepo;

  ViewsGraphBloc(this._viewsGraphRepo) : super(ViewsGraphLoadingState()) {
    on<ViewsGraphLoadingEvent>((event, emit) => emit(ViewsGraphLoadingState()));

    on<ViewsGraphLoadedEvent>((event, emit) {
      List<dynamic> viewsGraphFrontData = [];
      viewsGraphFrontData = _viewsGraphRepo.getViewsGraphData();
      emit(ViewsGraphLoadedState(viewsGraphFrontData));
    });
  }
}
