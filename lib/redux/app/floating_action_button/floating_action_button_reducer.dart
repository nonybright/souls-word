import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/redux/app/floating_action_button/floating_action_button_action.dart';

//TODO: Refactor and wrap floating action and appbaraction in a substate called uiState or so . Put the reducers in one file
FloatingActionButton floatinActionButtonReducer(FloatingActionButton state, action) {
  if (action is ChangeFloatingActionButton) {
    return action.floatingActionButton;
  }
  if (action is ClearFloatingActionButton) {
    return null;
  } else {
    return state;
  }
}