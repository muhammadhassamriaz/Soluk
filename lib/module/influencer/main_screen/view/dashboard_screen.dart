import 'package:app/module/influencer/dashboard/widget/circular_graph.dart';
import 'package:app/module/influencer/dashboard/widget/loading.dart';
import 'package:app/module/influencer/dashboard/widget/rounded_widget.dart';
import 'package:app/module/influencer/dashboard/widget/top_widget.dart';
import 'package:app/module/influencer/income_analytics/bloc/income_graph_bloc.dart';
import 'package:app/module/influencer/income_analytics/bloc/income_graph_event.dart';
import 'package:app/module/influencer/income_analytics/widget/income_graph_widget.dart';
import 'package:app/module/influencer/views_analytics/bloc/views_graph_bloc.dart';
import 'package:app/module/influencer/views_analytics/widget/views_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../res/constants.dart';
import '../../../../utils/shared_preference_manager.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltip = TooltipBehavior(enable: true);
    final _incomeGraphBloc = BlocProvider.of<IncomeGraphBloc>(context);
    final _viewsGraphBloc = BlocProvider.of<ViewsGraphBloc>(context);
    final String userName = PreferenceManager.instance.getString(PREFS_USERNAME);

    _incomeGraphBloc.add(IncomeGraphLoadingEvent());
    _viewsGraphBloc.add(ViewsGraphLoadingEvent());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.71.w, vertical: 6.5.h),
          child: Column(
            children: [
              topWidget(context, name: userName, notification: 1),

              // Income Graph
              BlocConsumer<IncomeGraphBloc, IncomeGraphState>(
                listener: (context, state) {
                  if (state is IncomeGraphLoadingState) {
                    Future.delayed(const Duration(milliseconds: 0), () {
                      _incomeGraphBloc.add(IncomeGraphLoadedEvent());
                    });
                  }
                },
                builder: (context, state) {
                  if (state is IncomeGraphLoadingState) {
                    return loading(context);
                  }
                  if (state is IncomeGraphLoadedState) {
                    return incomeGraphWidget(
                        graphData: state.getIncomeGraphData,
                        context: context,
                        tooltipBehavior: _tooltip);
                  }
                  return Container();
                },
              ),

              // Views Graph
              BlocConsumer<ViewsGraphBloc, ViewsGraphState>(
                listener: (context, state) {
                  if (state is ViewsGraphLoadingState) {
                    Future.delayed(const Duration(milliseconds: 0), () {
                      _viewsGraphBloc.add(ViewsGraphLoadedEvent());
                    });
                  }
                },
                builder: (context, state) {
                  if (state is ViewsGraphLoadingState) {
                    return loading(context);
                  }
                  if (state is ViewsGraphLoadedState) {
                    return ViewsGraph(
                      viewGraphData1: state.getViewsGraphData[0],
                      viewGraphData2: state.getViewsGraphData[1],
                    );
                  }
                  return Container();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  roundedWidget(context: context, value: '44'),
                  roundedWidget(context: context, isRating: true, value: '4.5'),
                ],
              ),
              const CircularGraph(
                published: 55,
                unPublished: 23,
              )
            ],
          ),
        ),
      ),
    );
  }
}
