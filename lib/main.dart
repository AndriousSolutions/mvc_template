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

import 'package:mvc_template/src/view.dart'
    show AppStatefulWidget, MyView, runApp;

/// We use the MVC framework's own runApp with its innate error handling.
void main() => runApp(
      MyApp(),
      errorHandler: null,
      errorScreen: null,
      errorReport: null,
    );

class MyApp extends AppStatefulWidget {
  /// Note, all the parameters available to you are passed null
  /// just so you see that they exist.
  MyApp()
      : super(
          con: null,
          key: null,
          loadingScreen: null,
          errorHandler: null,
          errorScreen: null,
          errorReport: null,
          allowNewHandlers: true,
        );

  /// Following the MVC architecture, your app begins with a View.
  /// MyView is the app's view and you go to that class to add any and all options
  /// that are to work at the 'app level.'
  /// It's also there, where you then provide the 'home' widget
  /// representing the view that's, in turn, your startup screen.
  /// Your app's not instantiated until all the Error Handling is in place.
  @override
  createView() => MyView();
}
