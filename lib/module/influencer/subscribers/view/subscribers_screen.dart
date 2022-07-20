import 'package:app/module/influencer/subscribers/bloc/subscriber_bloc.dart';
import 'package:app/module/influencer/subscribers/widget/subscribers_name_profile.dart';
import 'package:app/module/influencer/subscribers/widget/subscribers_top_widget.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../data/dummy_data.dart';

class SubscribersScreen extends StatelessWidget {
  static const id = 'SubscribersScreen';
  const SubscribersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _subscriberBloc = BlocProvider.of<SubscriberBloc>(context);
    _subscriberBloc.add(SubscribersListLoadingEvent());

    return Scaffold(
      body: AppBody(
          title: AppLocalisation.getTranslated(context, LKSubscribers),
          body: BlocConsumer<SubscriberBloc, SubscriberState>(
            listener: (context, state) {
              if(state is SubscribersListLoadingState){
                Future.delayed(const Duration(milliseconds: 0), (){
                  _subscriberBloc.add(SubscribersListLoadedEvent());
                });
              }
            },
            builder: (context, state) {
              if(state is SubscribersListLoadingState){
                return const Center(child: CircularProgressIndicator(color: Colors.grey,),);
              }
              if(state is SubscribersListLoadedState){
                return SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subscribersTopWidget(context, subscribers: state.subscribersList.length.toString()),
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(AppLocalisation.getTranslated(context, LKSubscriberList), style: headingTextStyle(context)!.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.subscribersList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return subscribersNameProfileWidget(context,
                              subscriberName: state.subscribersList[index].name,
                              subscriberProfile:
                                  state.subscribersList[index].imageUrl);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
