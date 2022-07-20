import 'package:app/module/influencer/income_analytics/widget/expansion_tile.dart';
import 'package:app/module/influencer/views_analytics/data/views_dummy_data.dart';
import 'package:app/module/influencer/views_analytics/widget/view_horizontal_container.dart';
import 'package:app/module/influencer/views_analytics/widget/views_graph.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/module/influencer/widgets/custom_app_bar.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewsScreen extends StatefulWidget {
  static const routeName = 'ViewsScreen';

  const ViewsScreen({Key? key}) : super(key: key);

  @override
  State<ViewsScreen> createState() => _ViewsScreenState();
}

class _ViewsScreenState extends State<ViewsScreen> {
  late TooltipBehavior _tooltip;
  bool isOverAllViewsSelected = true;
  bool isMonthlyViewsSelected = false;
  final PageController _pageController = PageController();

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    getViewsExpansionSummary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: AppBody(
        bgColor: backgroundColor,
        title: AppLocalisation.getTranslated(context, LKViews),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1.2.h),
              child: Row(
                children: [
                  choiceChipWidget(context,
                      title: AppLocalisation.getTranslated(
                          context, LKOverallViews),
                      isIncomeSelected: isOverAllViewsSelected,
                      onSelected: (val) {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                    setState(() {
                      isOverAllViewsSelected = true;
                      isMonthlyViewsSelected = false;
                    });
                  }),
                  Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: choiceChipWidget(context,
                        title:
                            AppLocalisation.getTranslated(context, LKMonthly),
                        isIncomeSelected: isMonthlyViewsSelected,
                        onSelected: (val) {
                      _pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                      setState(() {
                        isOverAllViewsSelected = false;
                        isMonthlyViewsSelected = true;
                      });
                    }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  switch (page) {
                    case 0:
                      setState(() {
                        isOverAllViewsSelected = true;
                        isMonthlyViewsSelected = false;
                      });
                      break;
                    case 1:
                      setState(() {
                        isOverAllViewsSelected = false;
                        isMonthlyViewsSelected = true;
                      });
                      break;
                  }
                },
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ViewsGraph(
                        viewGraphData1: viewChartDataList1,
                        viewGraphData2: viewChartDataList2,
                      ),
                      viewHorizontalContainer(context,
                          title: AppLocalisation.getTranslated(
                              context, LKOverallViews),
                          views: '1600')
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 0.99.h),
                          child: viewHorizontalContainer(context,
                              title: AppLocalisation.getTranslated(
                                  context, LKTotalViews),
                              views: '1600')),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 2.98.h),
                        child: Text(
                          AppLocalisation.getTranslated(context, LKHistory),
                          style: headingTextStyle(context)!.copyWith(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: ExpansionTileScreen(
                              isViews: true, viewsSummary: viewSummaryData))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
