import 'package:app/module/influencer/subscribers/data/dummy_data.dart';
import 'package:app/module/influencer/subscribers/model/subscribers.dart';

class SubscriberRepo{
  List<Subscribers> getSubscribersList(){
    return subscribersListData;
  }
}