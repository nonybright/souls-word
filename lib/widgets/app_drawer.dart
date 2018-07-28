import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_category_fragment.dart';
import 'package:flutter_emergency_app_one/pages/about.dart';
import 'package:flutter_emergency_app_one/pages/settings.dart';
import 'package:flutter_emergency_app_one/utils/device_detail.dart';
import 'package:flutter_emergency_app_one/widgets/home_fragment.dart';

class AppDrawer extends StatefulWidget {
  final Function(Widget) onMajorItemClicked;
  AppDrawer({Key key, this.onMajorItemClicked}) : super(key: key);

  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int majorItemPos = 0;
  List<_DrawerItem> majorDrawerItems = [
    _DrawerItem('Home', Icons.home),
    _DrawerItem('Verses', Icons.title),
    _DrawerItem('Quotes', Icons.time_to_leave),
    _DrawerItem('Images', Icons.title),
    _DrawerItem('Facts', Icons.texture),
    _DrawerItem('Notes', Icons.title),
  ];

  Widget _selectMajorFragment(index) {
    switch (index) {
      case 0:
        return HomeFragment();
        break;
      case 1:
        return VerseCategoryFragment();
      default:
        return Text('hello');
    }
  }

  List<_DrawerItem> getExtraDrawerItems(context) {
    DeviceDetail deviceDetail = new DeviceDetail(context);
    return [
      _DrawerItem('Settings', Icons.hotel, onTap: () {
        if (deviceDetail.isPhone()) {
          Navigator.pop(context);
        }
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new SettingsPage()),
        );
      }),
      _DrawerItem('About', Icons.hotel, onTap: () {
        if (deviceDetail.isPhone()) {
          Navigator.pop(context);
        }
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new AboutPage()),
        );
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [_drawerHeader()]..addAll(_majorWidgetListTiles()
          ..addAll(getExtraDrawerItems(context).map((item) {
            return _drawerTile(item, item.onTap);
          }).toList())),
      ),
    );
  }

  Widget _drawerTile(_DrawerItem drawerItem, onTap) {
    return ListTile(
      leading: new Icon(drawerItem.icon),
      title: Text(drawerItem.title),
      onTap: onTap,
    );
  }

  Widget _drawerHeader() {
    return Text('the header');
  }

  List<Widget> _majorWidgetListTiles() {
    /*(majorDrawerItems.map((item) {
						//TODO get index without for loop and without this hack if possible
						majorItemPos++;
						return _drawerTile(item, (majorItemPos) {
							widget.onMajorItemClicked(majorItemPos - 1);
						});
					}).toList();*/

    List<Widget> majorWidgetTile = [];
    for (int i = 0; i < majorDrawerItems.length; i++) {
      majorWidgetTile.add(_drawerTile(majorDrawerItems[i], () {
        widget.onMajorItemClicked(_selectMajorFragment(i));
      }));
    }
    return majorWidgetTile;
  }
}

class _DrawerItem {
  String title;
  IconData icon;
  Function onTap;

  _DrawerItem(this.title, this.icon, {this.onTap});
}
