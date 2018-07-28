import 'package:flutter/material.dart';

class DeviceDetail {
  static const TABLET_WITDTH = 1400;
  static const PHONE_WIDTH = 600;

  MediaQueryData deviceData;
  DeviceDetail(context) {
    deviceData = MediaQuery.of(context);
  }

  bool isPhone() {
    return deviceData.size.width <= DeviceDetail.PHONE_WIDTH;
  }

  bool isTablet() {
    return deviceData.size.width > DeviceDetail.PHONE_WIDTH &&
        deviceData.size.width <= DeviceDetail.TABLET_WITDTH;
  }
}
