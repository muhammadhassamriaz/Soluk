import 'package:app/module/influencer/challenges/cubit/comments_bloc/commentsbloc_cubit.dart';
import 'package:app/module/influencer/challenges/model/comments_modal.dart';
import 'package:app/utils/c_date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../animations/slide_up_transparent_animation.dart';
import '../../../../../res/constants.dart';
import '../../../../../res/globals.dart';
import '../../../../../services/localisation.dart';
import '../../../more/widget/custom_alert_dialog.dart';
import '../../../widgets/reward_popup.dart';
import '../../../widgets/saluk_gradient_button.dart';

class CommentTile extends StatelessWidget {
  final Data item;
  const CommentTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Text(
                    '${item.user?.fullname??''}',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigatorKey.currentState?.push(
                        SlideUpTransparentRoute(
                          enterWidget: CustomAlertDialog(
                            sigmaX: 0,
                            sigmaY: 0,
                            contentWidget: RewardPopUp(
                              iconPath: 'assets/images/ic_dialog_delete.png',
                              title: AppLocalisation.getTranslated(
                                  context, LKDelete),
                              content: AppLocalisation.getTranslated(
                                  context, LKConfirmDeleteComment),
                              actionButtons: Row(
                                children: [
                                  SizedBox(
                                    width: defaultSize.screenWidth * .37,
                                    child: SalukGradientButton(
                                      title: AppLocalisation.getTranslated(
                                          context, LKYes),
                                      onPressed: () async {
                                        BlocProvider.of<CommentsblocCubit>(
                                                context)
                                            .delete('${item.challengeId}',
                                                '${item.ccId}');
                                        Navigator.pop(context);
                                      },
                                      buttonHeight: HEIGHT_3,
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: defaultSize.screenWidth * .37,
                                    child: SalukGradientButton(
                                      title: AppLocalisation.getTranslated(
                                          context, LKNo),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      buttonHeight: HEIGHT_3,
                                      linearGradient: const LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Colors.black,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          routeName: CustomAlertDialog.id,
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.delete_rounded,
                        color: Color(0xffF85656),
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 2),
              Padding(
                padding: EdgeInsets.only(right: 14),
                child: Text(
                  '${item.description!}',
                  // 'Lorem ipsum dolor sit amet, consectetur adipis elit. Lacus, sit Rhoncus matti. Rhoncus, massa rutrum ut fermentum in.,',
                  style: TextStyle(fontSize: 12),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 1),
               Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${timeago.format(CDateFormat.parsetoDate(item.createdDate!))}',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ),
              const SizedBox(height: 4),
              const Divider(thickness: 0.6),
            ],
          ),
        )
      ],
    );
  }
}
