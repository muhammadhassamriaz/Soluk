import 'package:app/module/influencer/dashboard/model/chart.dart';
import '../../income_analytics/data/income_dummy_data.dart';

class IncomeGraphRepo{

  List<ChartData> getIncomeGraphData(){
    return incomeGraphFrontData;
  }

}