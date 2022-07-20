part of 'views_graph_bloc.dart';

abstract class ViewsGraphState extends Equatable {
  const ViewsGraphState();

  @override
  List<Object> get props => [];
}

class ViewsGraphLoadingState extends ViewsGraphState{}

class ViewsGraphLoadedState extends ViewsGraphState{
  final List<dynamic> _viewsGraphFrontData;
  const ViewsGraphLoadedState(this._viewsGraphFrontData);

  List<dynamic> get getViewsGraphData => _viewsGraphFrontData;
}

class ViewsGraphErrorState extends ViewsGraphState{}
