import 'package:app/module/influencer/dashboard/model/income_month_summary.dart';
import 'package:app/module/influencer/dashboard/model/month_name.dart';
import 'package:app/module/influencer/dashboard/model/views_month_summary.dart';
import 'package:app/module/influencer/income_analytics/data/income_dummy_data.dart';
import 'package:app/module/influencer/income_analytics/widget/income_horizontal_container.dart';
import 'package:app/module/influencer/views_analytics/widget/view_horizontal_container.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ExpansionTileScreen extends StatelessWidget {
  List<IncomeMonthSummary>? monthSummary;
  final bool? isViews;
  List<ViewsMonthSummary>? viewsSummary;
  ExpansionTileScreen({this.monthSummary, this.isViews, this.viewsSummary, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getMonths();

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: monthData.length,
        itemBuilder: (BuildContext context, int index) {
          return expansionTileWidget(monthData[index], monthSummary?[index], context, isViews: isViews ?? false, viewsSummary: viewsSummary?[index]);
        },
    );
  }

  Widget expansionTileWidget(Month month, IncomeMonthSummary? monthSummary, BuildContext context, {bool? isViews, ViewsMonthSummary? viewsSummary}) {
    return Card(
      margin: EdgeInsets.only(top: 1.h),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.49.h),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            iconColor: Colors.black,
            collapsedIconColor: Colors.black,
            title: Text(
              month.name,
              style: headingTextStyle(context)!.copyWith(
                  fontSize: 10.9.sp
              ),
            ),
            children: <Widget>[
              isViews!
                  ? viewHorizontalContainer(context, isExpansion: true, title: '', views: viewsSummary!.views)
                  : incomeHorizontalContainer(context, isExpansion: true, title:'',  totalIncome: monthSummary!.totalIncome, directSubEarning: monthSummary.directSubEarnings, viewsEarning: monthSummary.viewsEarning)
            ],
          ),
        ),
      ),
    );
  }
}
