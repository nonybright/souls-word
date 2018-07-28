import 'package:flutter_emergency_app_one/redux/app/updated/is_updated_action.dart';

bool isUpdatedReducer(bool state, action) {
  if (action is CheckUpdateSuccessfulAction) {
    return action.isUpdated;
  } else {
    return state;
  }
}
