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
/// can 'talk to' the View. (i.e. issue a setState() funciton call)
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
  bool get wordsApp => Prefs.getBool('words');

  /// Switch to the other application.
  void changeApp(){
    final app = Prefs.getBool('words');
    unawaited(Prefs.setBool('words', !app));
    App.refresh();
  }
}
