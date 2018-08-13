import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';

class AppViewModel {
  final List<Widget> appbarActions;
  final FloatingActionButton floatingActionButton;
  final Function changeAction; //TODO: remove this if it is not used for anything
  AppViewModel({this.appbarActions, this.floatingActionButton, this.changeAction});

  static AppViewModel fromStore(Store<AppState> store) {
    return AppViewModel(
        appbarActions: store.state.appbarActions,
        floatingActionButton: store.state.floatingActionButton,
        changeAction: () {
          print('change the current action from here');
        });
  }
}
