import 'package:app/module/influencer/dashboard/model/chart.dart';
import 'package:app/module/influencer/dashboard/model/income_month_summary.dart';
import 'package:app/module/influencer/dashboard/model/month_name.dart';

List<Month> monthData = [];
List<IncomeMonthSummary> monthSummaryData = [];

getMonths(){
  monthData = [
    Month(name: 'January'),
    Month(name: 'February'),
    Month(name: 'March'),
    Month(name: 'April'),
    Month(name: 'May'),
    Month(name: 'June'),
    Month(name: 'July'),
    Month(name: 'August'),
    Month(name: 'September'),
    Month(name: 'October'),
    Month(name: 'November'),
    Month(name: 'December'),
  ];
}

getIncomeExpansionSummary(){
  monthSummaryData = [
    IncomeMonthSummary(totalIncome: '1600K', directSubEarnings: '800K', viewsEarning: '300K'),
    IncomeMonthSummary(totalIncome: '1200K', directSubEarnings: '700K', viewsEarning: '700K'),
    IncomeMonthSummary(totalIncome: '1100K', directSubEarnings: '500K', viewsEarning: '250K'),
    IncomeMonthSummary(totalIncome: '1300K', directSubEarnings: '600K', viewsEarning: '35K'),
    IncomeMonthSummary(totalIncome: '1500K', directSubEarnings: '1000K', viewsEarning: '700K'),
    IncomeMonthSummary(totalIncome: '1700K', directSubEarnings: '1200K', viewsEarning: '800K'),
    IncomeMonthSummary(totalIncome: '1600K', directSubEarnings: '800K', viewsEarning: '300K'),
    IncomeMonthSummary(totalIncome: '1200K', directSubEarnings: '700K', viewsEarning: '700K'),
    IncomeMonthSummary(totalIncome: '1100K', directSubEarnings: '500K', viewsEarning: '250K'),
    IncomeMonthSummary(totalIncome: '1300K', directSubEarnings: '600K', viewsEarning: '35K'),
    IncomeMonthSummary(totalIncome: '1500K', directSubEarnings: '1000K', viewsEarning: '700K'),
    IncomeMonthSummary(totalIncome: '1700K', directSubEarnings: '1200K', viewsEarning: '800K'),
  ];
}

final List<ChartData> incomeGraphFrontData = [
  ChartData('Sat', 70),
  ChartData('Sun', 60),
  ChartData('Mon', 89),
  ChartData('Tue', 50),
  ChartData('Wed', 90),
  ChartData('Thurs', 50),
  ChartData('Fri', 76),
];

final List<ChartData> incomeGraphBackData = [
  ChartData('Sat', 100),
  ChartData('Sun', 100),
  ChartData('Mon', 100),
  ChartData('Tue', 100),
  ChartData('Wed', 100),
  ChartData('Thurs', 100),
  ChartData('Fri', 100),
];