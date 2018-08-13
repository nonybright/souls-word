import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_emergency_app_one/pages/app_view_model.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/app/appbaraction/app_bar_action_actions.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
import 'package:flutter_emergency_app_one/widgets/app_drawer.dart';
import 'package:flutter_emergency_app_one/widgets/home_fragment.dart';
import 'package:flutter_emergency_app_one/widgets/responsive_builder.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _selectedMajorFragment;
  bool _showTabletDrawer = true;

  List<Widget> _homePageWidgets = [
    IconButton(
      icon: Icon(Icons.group),
      onPressed: () => print('pressed'),
    )
  ];

  @override
  void initState() {
    super.initState();
    _selectedMajorFragment = new HomeFragment();
    // createDB();
  }

  /*createDB() {
    DatabaseHelper helper = new DatabaseHelper();
    helper.createFromAsset().then((nullz) => print('in create'));
  }*/

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppViewModel>(
      // TODO: Implement == and hashcode and set distinct to true;
      onInit: (store) {
        store.dispatch(ChangeActionWidget(_homePageWidgets));
        store.dispatch(LatestVerseAction());
        store.dispatch(GetVerseCategoryAction());
      },
      converter: (store) => AppViewModel.fromStore(store),
      builder: (_, viewModel) {
        return new ResponsiveBuilder(
          phone: _buildPhoneLayout(viewModel),
          tablet: _buildTabletLayout(viewModel),
        );
      },
    );
  }

  Widget _buildPhoneLayout(viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Souls Word'),
        actions: viewModel.appbarActions,
      ),
      body: _selectedMajorFragment,
      drawer: AppDrawer(
        onMajorItemClicked: (majorFragment) {
          Navigator.pop(context);
          setState(() {
            _selectedMajorFragment = majorFragment;
          });
        },
      ),
      floatingActionButton: viewModel.floatingActionButton,
    );
  }

  Widget _buildTabletLayout(viewModel) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            setState(() {
              _showTabletDrawer = !_showTabletDrawer;
            });
          },
        ),
        title: Text('Souls Word'),
        actions: viewModel.appbarActions,
      ),
      body: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: (_showTabletDrawer)
                ? AppDrawer(
                    //TODO: do not recreate drawer everytym
                    onMajorItemClicked: (majorFragment) {
                      setState(() {
                        _selectedMajorFragment = majorFragment;
                      });
                    },
                  )
                : Container(),
          ),
          Flexible(
            flex: 4,
            child: _selectedMajorFragment,
          ),
        ],
      ),
    );
  }
}
