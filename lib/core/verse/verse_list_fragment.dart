import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/models/loading_status.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_detail_card.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_model.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/utils/device_detail.dart';

enum VerseListAction {
  sortByDateDesc,
  sortByDateAsc,
  sortByBookDesc,
  sortByBookAsc,
}

class VerseListFragment extends StatefulWidget {
  final VerseDisplayType displayType;
  final categoryId;
  VerseListFragment(this.displayType, {Key key, this.categoryId}) : super(key: key);

  @override
  _VerseListFragmentState createState() =>  _VerseListFragmentState();
}

class _VerseListFragmentState extends State<VerseListFragment> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VerseViewModel>(
      converter: (store) => VerseViewModel.fromStore(store, widget.displayType, categoryId:widget.categoryId),
      builder: (_, viewModel) => VerseListContent(
            widget.displayType,
            viewModel.displayedVerses,
            onVerseClicked: viewModel.onVerseClicked,
            onShareClicked: viewModel.onShareClicked,
            onShareImageClicked: viewModel.onShareImageClicked,
            onFavToggleClicked: viewModel.onFavToggleClicked,
            onLoadMore: viewModel.onLoadMore,
            loadingStatus: viewModel.loadingStatus,
          ),
    );
  }
}

class VerseListContent extends StatelessWidget {
  final List<Verse> currentVerses;
  final Function(Verse) onVerseClicked;
  final VerseDisplayType displayType;
  final Function(Verse) onShareClicked;
  final Function(Verse)
      onShareImageClicked; //TODO: these shouldnt be here just to be passed to verse detail card, ceate a viewmodel for the detailcard
  final Function(Verse) onFavToggleClicked;
  final Function() onLoadMore;
  final LoadingStatus loadingStatus;

  VerseListContent(this.displayType, this.currentVerses,
      {this.onVerseClicked,
      this.onShareClicked,
      this.onShareImageClicked,
      this.onFavToggleClicked,
      this.onLoadMore,
      this.loadingStatus});

  @override
  Widget build(BuildContext context) {
    //will be gridbuilder
    return  GridView.builder(
      itemCount: currentVerses.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: DeviceDetail(context).isPhone() ? 1 : 2,
      ),
      itemBuilder: (context, index) {
        print(index);
         if (index >= currentVerses.length - 2 && loadingStatus != LoadingStatus.loadingMore) {
          onLoadMore();
        } 
        return VerseDetailCard(
          currentVerses[index],
          onShareClicked: onShareClicked,
          onShareImageClicked: onShareImageClicked,
          onFavToggleClicked: onFavToggleClicked,
          onVerseTapped: () {
            onVerseClicked(currentVerses[index]);
            Navigator.push(
              context,
               MaterialPageRoute(
                  builder: (context) =>  VerseViewPage(displayType, index)),
            );
          },
        );
      },
    );
  }
}
