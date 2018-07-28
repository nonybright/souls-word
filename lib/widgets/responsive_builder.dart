import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/utils/device_detail.dart';

// class ResponsiveBuilder extends LayoutBuilder{

//   final Widget phone;
//   final Widget tablet;
//   final Key key;
//   final LayoutWidgetBuilder builder;

//   ResponsiveBuilder({@required this.phone, this.tablet, this.builder, this.key}):super(key:key, builder:builder);
// }

class ResponsiveBuilder extends StatefulWidget {
  final Widget phone;
  final Widget tablet;

  ResponsiveBuilder({Key key, @required this.phone, this.tablet})
      : assert(phone != null),
        super(key: key);

  @override
  _ResponsiveBuilderState createState() => new _ResponsiveBuilderState();
}

class _ResponsiveBuilderState extends State<ResponsiveBuilder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      DeviceDetail detail = new DeviceDetail(context);

      if (detail.isPhone()) {
        return _getPhone();
      } else if (detail.isTablet()) {
        print("-----------------------IS TABLET");
        return _getTablet();
      } else {
        return _getTablet();
      }
    });
  }

  Widget _getPhone() {
    return widget.phone;
  }

  Widget _getTablet() {
    if (widget.tablet != null) {
      return widget.tablet;
    } else {
      return _getPhone();
    }
  }

  /* 
    //will be used when targeting tv
    Widget _getTV(){

    if(widget.tv != null){
      return widget.tv;
    }else{
      return _getTablet();
    }
  }*/
}
