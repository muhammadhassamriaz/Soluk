import '../data/views_dummy_data.dart';

class ViewsGraphRepo{
  List<dynamic> viewsGraphData = [];

  List<dynamic> getViewsGraphData(){
    viewsGraphData.add(viewChartDataList1);
    viewsGraphData.add(viewChartDataList2);

    return viewsGraphData;
  }
}