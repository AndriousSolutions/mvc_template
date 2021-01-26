///
/// Copyright (C) 2021 Andrious Solutions Ltd.
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  01 Jan 2021
///

///
/// Controller for the home screen.
///

// You can see 'at a glance' this Controller 'talks to' the Model.
import 'package:starter_app/src/model.dart';

// You can see 'at a glance' this Controller also 'talks to' the interface (View).
import 'package:starter_app/src/view.dart';

import 'package:starter_app/src/controller.dart';

/// extends 'ControllerMVC' so if added to a State object
/// can 'talk to' the View. (i.e. issue a setState() function call)
class Controller extends ControllerMVC {
  factory Controller() => _this ??= Controller._();
  Controller._() {
    _model = Model();
  }
  static Controller _this;

  Model _model;

  String get data => _model.data;

  void onPressed() => _model.onPressed();

  // Assign to the 'leading' widget on the interface.
  void leading() => changeUI();

  /// Switch to the other User Interface.
  void changeUI() {
    //
    Navigator.popUntil(App.context, ModalRoute.withName('/'));

    App.changeUI(App.useMaterial ? 'Cupertino' : 'Material');
    bool switchUI;
    if (App.useMaterial) {
      if (UniversalPlatform.isAndroid) {
        switchUI = false;
      } else {
        switchUI = true;
      }
    } else {
      if (UniversalPlatform.isAndroid) {
        switchUI = true;
      } else {
        switchUI = false;
      }
    }
    Prefs.setBool('switchUI', switchUI);
  }

  /// Indicate if the Words app is to run.
  bool get wordsApp => appNames[_appCount] == 'Word Pairs';

  /// Indicate if the Counter app is to run.
  bool get counterApp => appNames[_appCount] == 'Counter';

  /// Indicate if the Contacts app is to run.
  bool get contactsApp => appNames[_appCount] == 'Contacts';

  int _appCount = 0;
  final appNames = ['Word Pairs', 'Counter', 'Contacts'];

  Widget onHome() {
    _appCount = Prefs.getInt('appRun');
    final Key key = UniqueKey();
    Widget widget;
    switch (appNames[_appCount]) {
      case 'Word Pairs':
        widget = WordPairs(key: AppState.homeKey);
        break;
      case 'Counter':
        widget = HomePage(key: AppState.homeKey);
        break;
      case 'Contacts':
        widget = ContactsList(key: key);
        break;
    }
    return widget;
  }

  // Supply what the interface
  String get application => appNames[_appCount];

  /// Switch to the other application.
  void changeApp([String appName = '']) {
    if (appName == null ||
        appName.isEmpty ||
        !appNames.contains(appName.trim())) {
      //
      _appCount++;
      if (_appCount == appNames.length) {
        _appCount = 0;
      }
    } else {
      _appCount = appNames.indexOf(appName.trim());
    }

    unawaited(Prefs.setBool('words', appNames[_appCount] == 'Word'));

    unawaited(Prefs.setInt('appRun', _appCount));

    App.refresh();
  }

  /// Working with the ColorPicker to change the app's color theme
  void onColorPicker([ColorSwatch<int> value]) {
    //
    if (value == null) {
      final swatch = Prefs.getInt('colorTheme', -1);
      // If never set in the first place, ignore
      if (swatch > -1) {
        value = ColorPicker.colors[swatch];
        ColorPicker.colorSwatch = value;
      }
    } else {
      Prefs.setInt('colorTheme', ColorPicker.colors.indexOf(value));
    }

    if (value == null) {
      return;
    }

    /// Assign the colour to the floating button as well.
    App.themeData = ThemeData(
      primaryColor: value,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: value,
      ),
    );

    App.iOSTheme = value;

    // Rebuild the state.
    App.refresh();
  }
}
