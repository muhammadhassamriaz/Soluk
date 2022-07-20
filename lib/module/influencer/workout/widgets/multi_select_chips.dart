import 'dart:collection';

import 'package:app/module/influencer/workout/bloc/about_me_bloc/aboutmebloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/tags_bloc/tagsbloc_cubit.dart';
import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/module/influencer/workout/tags_list.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class MultiSelectChip extends StatefulWidget {
  final ValueChanged<List<int>> selectedTags;
  final TagsModel tagsModel;
  const MultiSelectChip(
      {Key? key, required this.tagsModel, required this.selectedTags})
      : super(key: key);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<Data> selectedChoices = [];
  List<int> selectedIds = [];
  @override
  void initState() {
    super.initState();
     AboutmeblocCubit _abouttBloc = BlocProvider.of(context);
   selectedChoices= widget.tagsModel.responseDetails!.data??[];
      for (var element
        in _abouttBloc.state.influencerModel?.responseDetails?.tags??[]) {
      selectedIds.add(element.id!);
    }
  }
  _buildChoiceList(BuildContext context) {
    List<Widget> choices = [];
    for (var item in selectedChoices) {

      choices.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ChoiceChip(
          labelPadding: EdgeInsets.symmetric(horizontal: 10),
          label: Text(
            item.name!,
            style: labelTextStyle(context)!.copyWith(
                fontSize: defaultSize.screenWidth * .03,
                // color: Colors.grey
                color:
                    selectedIds.contains(item.id) ? Colors.white : Colors.grey),
          ),
          selectedColor: Colors.blue,
          backgroundColor: const Color(0xFFf4f4f4),
          selected: selectedIds.contains(item.id),
          onSelected: (selected) {
            // if(selectedChoices.contains(item)){
            //   selectedChoices.remove(item);
            // }else{
            //   selectedChoices.add(item);
            // }
             setState(() {

               selectedIds.contains(item.id)
                   ? selectedIds.remove(item.id)
                   : selectedIds.add(item.id!);
             });
          },
        ),
      ));
    }
    // List<String> list = LinkedHashSet<String>.from(selectedChoices).toList();
    widget.selectedTags(selectedIds);
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    TagsblocCubit _aboutBloc = BlocProvider.of(context, listen: false);
   
 

    return SizedBox(
      height: 20.h,
      child: RefreshWidget(
        refreshController: _aboutBloc.tagsRefCont,
        onLoadMore: () {
          _aboutBloc.getTags(initial: false);
        },
        onRefresh: () {},
        enablePullDown: false,
        child: SingleChildScrollView(
          child: BlocBuilder<TagsblocCubit, TagsblocState>(
            builder: (context, state) {
              return Wrap(
                spacing: -1,
                runSpacing: -5,
                children: _buildChoiceList(context),
              );
            },
          ),
        ),
      ),
    );
  }
}
