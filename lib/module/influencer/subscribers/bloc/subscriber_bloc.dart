import 'dart:async';

import 'package:app/module/influencer/subscribers/model/subscribers.dart';
import 'package:app/module/influencer/subscribers/repo/subscribers_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'subscriber_event.dart';
part 'subscriber_state.dart';

class SubscriberBloc extends Bloc<SubscriberEvent, SubscriberState> {
  final SubscriberRepo _subscriberRepo;

  SubscriberBloc(this._subscriberRepo) : super(SubscribersListLoadingState()) {
    on<SubscribersListLoadingEvent>((event, emit) => emit(SubscribersListLoadingState()));
    on<SubscribersListLoadedEvent>((event, emit) {
      List<Subscribers> _subscribersList = [];
      _subscribersList = _subscriberRepo.getSubscribersList();
      emit(SubscribersListLoadedState(_subscribersList));
    });
  }
}
