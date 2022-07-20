import 'package:app/module/influencer/income_analytics/data/income_dummy_data.dart';
import 'package:app/module/influencer/income_analytics/widget/expansion_tile.dart';
import 'package:app/module/influencer/income_analytics/widget/income_graph_widget.dart';
import 'package:app/module/influencer/income_analytics/widget/income_horizontal_container.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeScreen extends StatefulWidget {
  static const routeName = 'IncomeScreen';

  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  late TooltipBehavior _tooltip;
  bool isOverAllIncomeSelected = true;
  bool isMonthlyIncomeSelected = false;
  final PageController _pageController = PageController();

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    getIncomeExpansionSummary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: AppBody(
        bgColor: backgroundColor,
        title: AppLocalisation.getTranslated(context, LKIncome),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1.2.h),
              child: Row(
                children: [
                  choiceChipWidget(context,
                      title: AppLocalisation.getTranslated(
                          context, LKOverallIncome),
                      isIncomeSelected: isOverAllIncomeSelected,
                      onSelected: (val) {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                    setState(() {
                      isOverAllIncomeSelected = true;
                      isMonthlyIncomeSelected = false;
                    });
                  }),
                  Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: choiceChipWidget(context,
                        title:
                            AppLocalisation.getTranslated(context, LKMonthly),
                        isIncomeSelected: isMonthlyIncomeSelected,
                        onSelected: (val) {
                      _pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                      setState(() {
                        isOverAllIncomeSelected = false;
                        isMonthlyIncomeSelected = true;
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
                        isOverAllIncomeSelected = true;
                        isMonthlyIncomeSelected = false;
                      });
                      break;
                    case 1:
                      setState(() {
                        isOverAllIncomeSelected = false;
                        isMonthlyIncomeSelected = true;
                      });
                      break;
                  }
                },
                children: [
                  Column(
                    children: [
                      incomeGraphWidget(
                          context: context,
                          graphData: incomeGraphFrontData,
                          tooltipBehavior: _tooltip),
                      incomeHorizontalContainer(context,
                          title: AppLocalisation.getTranslated(
                              context, LKTotalIncome),
                          totalIncome: '1600K',
                          directSubEarning: '800K',
                          viewsEarning: '800K')
                      // totalIncomeWidget(),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.99.h),
                        child: incomeHorizontalContainer(context,
                            title: AppLocalisation.getTranslated(
                                context, LKTotalIncome),
                            totalIncome: '1600K',
                            directSubEarning: '800K',
                            viewsEarning: '800K'),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 2.98.h),
                        child: Text(
                          AppLocalisation.getTranslated(context, LKHistory),
                          style: headingTextStyle(context)!
                              .copyWith(fontSize: 15.6.sp),
                        ),
                      ),
                      Expanded(
                          child: ExpansionTileScreen(
                              monthSummary: monthSummaryData))
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
