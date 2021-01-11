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

import 'package:mvc_template/src/view.dart';

import 'package:mvc_template/src/controller.dart';

class Controller extends ControllerMVC {
  /// Optional but a good practice to use a factory constructor for a Controller.
  factory Controller() => _this ??= Controller._();
  static Controller _this;
  Controller._() : super();

  /// The remaining functions below are all optional.
  /// They hook into the State object associated with this Controller if any.
  /// Anything a State object can do, you can do here.
  /// Many of the function reflect the lifecycle of the State object.

  /// Initialize any 'time-consuming' operations at the beginning.
  /// Initialize asynchronous items essential to the Mobile Applications.
  /// Typically called within a FutureBuilder() widget.
  ///
  @override
  Future<bool> initAsync() async {
    return true;
  }

  /// The framework will call this method exactly once.
  /// Only when the Controller's [State] object is first created.
  ///
  @override
  void initState() async {}

  /// The framework calls this method when the Controller's [State] object will never
  /// build again.Note: THERE IS NO GUARANTEE THIS METHOD WILL RUN in the Framework.
  ///
  @override
  void dispose() {
    super.dispose();
  }

  /// The framework calls this method whenever it removes this [State] object
  /// from the tree.
  ///
  @override
  void deactivate() {}

  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  ///
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {}

  /// Called when the system puts the app in the background or
  /// returns the app to the foreground.
  /// Passing these possible values:
  /// AppLifecycleState.paused (may enter the suspending state at any time)
  /// AppLifecycleState.resumed
  /// AppLifecycleState.inactive (may be paused at any time)
  /// AppLifecycleState.suspending (Android only)
  ///
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  ///
  @override
  void didChangeMetrics() {}

  /// Called when the platform's text scale factor changes.
  ///
  @override
  void didChangeTextScaleFactor() {}

  /// Called when the system tells the app that the user's locale has changed.
  ///
  @override
  void didChangeLocale(Locale locale) {}

  /// Called when the system is running low on memory.
  ///
  @override
  void didHaveMemoryPressure() {}

  /// Called when the system changes the set of active accessibility features.
  ///
  @override
  void didChangeAccessibilityFeatures() {}

  /// Called when a dependency of the Controller's [State] object changes.
  ///
  @override
  void didChangeDependencies() {}

  /// During development, if a hot reload occurs, the reassemble method is called.
  /// This provides an opportunity to reinitialize any data that was prepared
  /// in the initState method.
  ///
  @override
  void reassemble() {}

  /// Provide the setState() function to the Controller
  ///
  @override
  void setState(fn) {}

  /// This is the same as the setState() function.
  ///
  @override
  void refresh() {}

  /// This is the same at the setState() functions.
  /// Allow for a more accurate description
  ///
  @override
  void rebuild() {}

  /// This is the same as the setState() functions.
  /// For those accustom to the 'Provider' approach.
  ///
  @override
  void notifyListeners() {}
}
