import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/redux/app/appbaraction/app_bar_action_actions.dart';

List<Widget> actionBarActionReducer(List<Widget> state, action) {
  if (action is ChangeActionWidget) {
    return action.actionWidget;
  }
  if (action is ClearActionWidget) {
    return [];
  } else {
    return state;
  }
}
