part of 'views_graph_bloc.dart';

abstract class ViewsGraphEvent extends Equatable {
  const ViewsGraphEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class ViewsGraphLoadingEvent extends ViewsGraphEvent{}

class ViewsGraphLoadedEvent extends ViewsGraphEvent{}

class ViewsGraphErrorEvent extends ViewsGraphEvent{}
