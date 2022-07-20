import 'package:app/module/influencer/dashboard/model/chart.dart';
import 'package:app/module/influencer/dashboard/model/views_month_summary.dart';

List<ViewsMonthSummary> viewSummaryData = [];

final List<ChartData> viewChartDataList1 = [
  ChartData('Sat', 35),
  ChartData('Sun', 13),
  ChartData('Mon', 34),
  ChartData('Tue', 27),
  ChartData('Wed', 50),
  ChartData('Thurs', 20),
  ChartData('Fri', 40)
];

final List<ChartData> viewChartDataList2 = [
  ChartData('Sat', 30),
  ChartData('Sun', 20),
  ChartData('Mon', 10),
  ChartData('Tue', 35),
  ChartData('Wed', 40),
  ChartData('Thurs', 35),
  ChartData('Fri', 30)
];

getViewsExpansionSummary(){
  viewSummaryData = [
    ViewsMonthSummary(views: '1600'),
    ViewsMonthSummary(views: '1200'),
    ViewsMonthSummary(views: '1300'),
    ViewsMonthSummary(views: '1000'),
    ViewsMonthSummary(views: '1800'),
    ViewsMonthSummary(views: '2600'),
    ViewsMonthSummary(views: '600'),
    ViewsMonthSummary(views: '1600'),
    ViewsMonthSummary(views: '1200'),
    ViewsMonthSummary(views: '1300'),
    ViewsMonthSummary(views: '1000'),
    ViewsMonthSummary(views: '1800'),
    ViewsMonthSummary(views: '2600'),
    ViewsMonthSummary(views: '600'),
  ];
}