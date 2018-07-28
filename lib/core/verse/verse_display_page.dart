import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_list_fragment.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_model.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';

class VerseDisplayPage extends StatefulWidget {
  final int verseCategoryId;
  final VerseDisplayType type;
  VerseDisplayPage({Key key, this.verseCategoryId, this.type})
      : super(key: key);

  @override
  _VerseDisplayPageState createState() => new _VerseDisplayPageState();
}

class _VerseDisplayPageState extends State<VerseDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VerseViewModel>(
      // TODO: Implement == and hashcode and set distinct to true;
      converter: (store) => VerseViewModel.fromStore(store, null,
          categoryId: widget.verseCategoryId),
      builder: (_, viewModel) {
        return _getDisplay(
            viewModel); //TODO: Change _getDisplay to a statless widget , a content for this stateless widget above
      },
    );
  }

  _getDisplay(VerseViewModel viewModel) {
    List<Widget> actions = [
      //random
      new PopupMenuButton<VerseListAction>(
        itemBuilder: (BuildContext context) => <PopupMenuItem<VerseListAction>>[
              const PopupMenuItem<VerseListAction>(
                value: VerseListAction.sortByDateAsc,
                child: Text('Sort By Date Desc'),
              ),
              const PopupMenuItem<VerseListAction>(
                value: VerseListAction.sortByDateAsc,
                child: Text('Sort By Date Asc'),
              ),
              const PopupMenuItem<VerseListAction>(
                value: VerseListAction.sortByBookAsc,
                child: Text('Sort By Book Desc'),
              ),
              const PopupMenuItem<VerseListAction>(
                value: VerseListAction.sortByBookDesc,
                child: Text('Sort By Book Asc'),
              ),
            ],
        onSelected: (VerseListAction action) {
          switch (action) {
            case VerseListAction.sortByDateDesc:
              viewModel.onSortByDateDesc();
              break;
            case VerseListAction.sortByDateAsc:
              viewModel.onSortByDateAsc();

              break;
            case VerseListAction.sortByBookDesc:
              viewModel.onSortByBookDesc();
              break;
            case VerseListAction.sortByBookAsc:
              viewModel.onSortByBookAsc();
              break;
          }
        },
      )
    ];

    return (widget.verseCategoryId != null)
        ? _getCategoryView(actions)
        : _getDisplayAllView(actions);
  }

  Widget _getCategoryView(actions) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('display'),
          actions: actions,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.favorite)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            VerseListFragment(VerseDisplayType.category, categoryId: widget.verseCategoryId),
            VerseListFragment(VerseDisplayType.favorite, categoryId: widget.verseCategoryId),
          ],
        ),
      ),
    );
  }

  Widget _getDisplayAllView(action) {
    return Scaffold(
      appBar: AppBar(
        title: Text('display'),
      ),
      body: VerseListFragment(widget
          .type),
    );
  }
}
