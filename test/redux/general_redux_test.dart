import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_emergency_app_one/redux/app/app_reducer.dart';
import 'package:redux/redux.dart';


void main(){

  test('Can use middleware', () {

    dynamic action;
    bool middlewareCalled;
    
    Store<AppState> store = Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [(Store<AppState> store , gottenAction , NextDispatcher next){

        action = gottenAction;
        middlewareCalled = true;
    },
    ]);

    store.dispatch(CanTestAction());
    expect(middlewareCalled, true);
    expect(action, const isInstanceOf<CanTestAction>());
  });

  test('Next middleware not called', () {

    bool nextMiddlewareCalled;
    
    Store<AppState> store = Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [(Store<AppState> store , gottenAction , NextDispatcher next){

       nextMiddlewareCalled = false;
    },
    (Store<AppState> store , gottenAction , NextDispatcher next){

        nextMiddlewareCalled = true;
    },
    ]);

    store.dispatch(CanTestAction());
    expect(nextMiddlewareCalled, false);
  });

   test('Should Call next middleware', () {

    bool nextMiddlewareCalled;
    
    Store<AppState> store = Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [(Store<AppState> store , gottenAction , NextDispatcher next){

       nextMiddlewareCalled = false;
       next(gottenAction);
    },
    (Store<AppState> store , gottenAction , NextDispatcher next){
        nextMiddlewareCalled = true;
    },
    ]);

    store.dispatch(CanTestAction());
    expect(nextMiddlewareCalled, true);
  });


  
   test('Should Call class Middleware', () {

    Counter counter = new Counter(5);
    
    Store<AppState> store = Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [MyMiddleWare(counter)]
    
    );

    store.dispatch(IncrementAction());
    expect(counter.val, 6);

    store.dispatch(DecrementAction());
    expect(counter.val, 5);

    store.dispatch(DecrementAction());
    store.dispatch(DecrementAction());
    expect(counter.val, 3);


  });
}


class MyMiddleWare extends MiddlewareClass<AppState>{

 Counter counter;
 MyMiddleWare(this.counter);
 
  @override
  void call(Store<AppState> store, action, NextDispatcher next) {

    next(action);
    // TODO: implement call
      if(action is IncrementAction){
        counter.increment();
      }else if(action is DecrementAction){
        counter.decrement();
      }
  }
}

class CanTestAction{}

class Counter{

    int _val;

    Counter(this._val);

    increment(){
      _val++;
    }

    decrement(){
      _val--;
    }

    get val => _val;

}

class IncrementAction{}
class DecrementAction{}