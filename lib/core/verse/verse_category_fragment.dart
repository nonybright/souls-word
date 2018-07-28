import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_category_view_model.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_display_page.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse_category.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/app/appbaraction/app_bar_action_actions.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
import 'package:flutter_emergency_app_one/widgets/badge.dart';
import 'package:flutter_emergency_app_one/widgets/responsive_builder.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_selectors.dart';

class VerseCategoryFragment extends StatefulWidget {
  VerseCategoryFragment({Key key}) : super(key: key);

  @override
  _VerseCategoryFragmentState createState() =>
      new _VerseCategoryFragmentState();
}

class _VerseCategoryFragmentState extends State<VerseCategoryFragment> {
  List<Widget> _getVerseCategoryAction(Store store) {
    return [
      IconButton(
        icon: Icon(Icons.list),
        onPressed: () {
          //dispatch get All;
          store.dispatch(new GetCurrentVersesAction(true,
              verseCountSelector(store.state,VerseDisplayType.category), VerseDisplayType.category,
              action: null));
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new VerseDisplayPage(
                      type: VerseDisplayType.category,
                    )),
          );
        },
      ), //all verses
      IconButton(
        icon: Icon(Icons.favorite),
        onPressed: () {
          //dispatch get all with favorite as part of action
          store.dispatch(new GetCurrentVersesAction(true,
              verseCountSelector(store.state,VerseDisplayType.favorite), VerseDisplayType.favorite,
              action: null));
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new VerseDisplayPage(
                      type: VerseDisplayType.favorite,
                    )),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VerseCategoryViewModel>(
      onInit: (store) {
        store.dispatch(ChangeActionWidget(_getVerseCategoryAction(store)));
      },
      onDispose: (store) => store.dispatch(ChangeActionWidget([])),
      converter: (store) => VerseCategoryViewModel.fromStore(store),
      builder: (_, viewModel) => VerseCategoryContent(viewModel),
    );
  }
}

//TODO: make this presentation independent of viewmodel
class VerseCategoryContent extends StatelessWidget {
  final VerseCategoryViewModel viewModel;

  VerseCategoryContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return new ResponsiveBuilder(
      phone: _buildPhoneLayout(),
      tablet: _buildTabletLayout(),
    );
  }

  Widget _buildPhoneLayout() {
    return new ListView.builder(
      itemCount: this.viewModel.verseCategories.length,
      itemBuilder: (context, index) {
        return _categoryListTile(
          context,
          this.viewModel.verseCategories[index],
          this.viewModel.verseCount(this.viewModel.verseCategories[index].id),
          () {
            this
                .viewModel
                .onCategoryClicked(this.viewModel.verseCategories[index].id);
          },
        );
      },
    );
  }

  Widget _buildTabletLayout() {
    return new GridView.builder(
      itemCount: this.viewModel.verseCategories.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return _categoryGridTile(
          context,
          this.viewModel.verseCategories[index],
          this.viewModel.verseCount(this.viewModel.verseCategories[index].id),
          () {
            this
                .viewModel
                .onCategoryClicked(this.viewModel.verseCategories[index].id);
          },
        );
      },
    );
  }

  Widget _categoryListTile(
      context, VerseCategory verseCategory, int itemCount, onCategoryTapped) {
    return ListTile(
      title: Text(verseCategory.name),
      trailing: Badge(
        itemCount.toString(),
        size: BadgeSize.small,
      ),
      onTap: () {
        onCategoryTapped();
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new VerseDisplayPage(
                    verseCategoryId: verseCategory.id,
                  )),
        );
      },
    );
  }

  Widget _categoryGridTile(
      context, VerseCategory verseCategory, int itemCount, onCategoryTapped) {
    return new GestureDetector(
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: GridTile(
          child: new Container(
            width: 200.0,
            height: 200.0,
            color: Colors.pink,
          ),
          footer: new Row(
            children: <Widget>[
              Expanded(
                child: Text(verseCategory.name),
              ),
              Badge(
                itemCount.toString(),
                size: BadgeSize.small,
              )
            ],
          ),
        ),
      ),
      onTap: () {
        onCategoryTapped();
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new VerseDisplayPage(
                    verseCategoryId: verseCategory.id,
                  )),
        );
      },
    );
  }
}
