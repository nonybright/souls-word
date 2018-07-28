import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';

class AppViewModel {
  final List<Widget> appbarActions;
  final Function changeAction;
  AppViewModel({this.appbarActions, this.changeAction});

  static AppViewModel fromStore(Store<AppState> store) {
    return AppViewModel(
        appbarActions: store.state.appbarActions,
        changeAction: () {
          print('change the current action from here');
        });
  }
}
