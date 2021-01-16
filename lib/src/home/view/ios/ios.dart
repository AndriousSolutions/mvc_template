import 'package:mvc_template/src/view.dart';

///
/// Copyright (C) 2020 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  21 Apr 2020
///

import 'package:mvc_template/src/controller.dart';

class MyiOS extends StateMVC<MyHome> {
  //
  MyiOS() : super(Controller()) {
    con = Controller();
  }
  Controller con;

  @override
  Future<bool> initAsync() async {
    await super.initAsync();
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  /// The View component of this MVC design pattern!
  @override
  Widget build(BuildContext context) => Container(width: 0, height: 0);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
  }

  @override
  void didChangeLocale(Locale locale) {
    super.didChangeLocale(locale);
  }

  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
  }

  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void setState(VoidCallback fn) {}

  @override
  void refresh() {}

  @override
  void onError(FlutterErrorDetails details) {
    super.onError(details);
  }
}
