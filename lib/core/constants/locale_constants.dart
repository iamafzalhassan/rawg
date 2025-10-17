import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocaleConstants {
  static get languages => [
    {'locale': const Locale('en', 'US'), 'name': 'languages.english'.tr()},
    {'locale': const Locale('si', 'LK'), 'name': 'languages.sinhala'.tr()},
  ];
}