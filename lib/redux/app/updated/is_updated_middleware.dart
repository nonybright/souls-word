//goes to server to check if it has been recently updated
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/app/updated/is_updated_action.dart';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/services/repository/app_repository.dart';

List<Middleware<AppState>> createLoginMiddleWare() {
  AppRepository repo = AppRepository();

  return [
    new TypedMiddleware<AppState, CheckUpdatedAction>(checkLogDetails(repo))
  ];
}

Middleware<AppState> checkLogDetails(AppRepository repo) {
  return (Store store, action, NextDispatcher next) async {
    if (action is CheckUpdatedAction) {
      try {
        bool isUpdated = await repo.isUpdated();
        store.dispatch(CheckUpdateSuccessfulAction(isUpdated));
        if (!isUpdated) {
          //TODO: Dispatch the action that will trigger getting the latest updates
        }
      } catch (error) {
        // TODO: make sure you dont leave an empty catch block
      }
    }
  };
}
