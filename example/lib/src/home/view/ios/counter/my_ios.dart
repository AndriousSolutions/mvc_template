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

import 'package:starter_app/src/view.dart';

import 'package:starter_app/src/controller.dart';

class HomePageiOS extends StateMVC<HomePage> {
  // Constructor registers a Controller
  HomePageiOS() : super(Controller()) {
    con = controller;
  }
  Controller con;

  @override
  void initState() {
    super.initState();
    _title = App.title;
  }

  String _title;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(_title ?? widget.title),
        trailing: PopMenu(context).popupMenuButton,
      ),
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends StateMVC<_HomeScreen> {
  // Constructor registers a Controller
  _HomeScreenState() : super(Controller()) {
    con = controller;
  }
  Controller con;

  // Merely for demonstration purposes. Erase if not using.
  /// Initialize any 'time-consuming' operations at the beginning.
  /// Initialize asynchronous items essential to the Mobile Applications.
  /// Typically called within a FutureBuilder() widget.
  @override
  Future<bool> initAsync() {
    return super.initAsync();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding initAsync() routine.
  /// Returns true if the error was properly handled.
  @override
  bool onAsyncError(FlutterErrorDetails details) {
    return false;
  }

  // Merely for demonstration purposes. Erase if not using.
  /// The framework will call this method exactly once.
  /// Only when the [State] object is first created.
  @override
  void initState() {
    super.initState();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// The framework calls this method whenever it removes this [State] object
  /// from the tree.
  @override
  void deactivate() {
    super.deactivate();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// The framework calls this method when this [State] object will never
  /// build again.
  /// Note: THERE IS NO GUARANTEE THIS METHOD WILL RUN in the Framework.
  @override
  void dispose() {
    super.dispose();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Calls setState((){});
  @override
  void refresh() {
    super.refresh();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// An 'error handler' routine to fire when an error occurs.
  /// Allows the user to define their own with each State.
  @override
  void onError(FlutterErrorDetails details) {
    super.onError(details);
  }

  // Merely for demonstration purposes. Erase if not using.
  // ignore: comment_references
  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when a dependency of this [State] object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {
    super.reassemble();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  /// Observers are notified in registration order until one returns
  /// true. If none return true, the application quits.
  @override
  Future<bool> didPopRoute() async {
    return super.didPopRoute();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the host tells the app to push a new route onto the
  /// navigator.
  ///
  /// Observers are expected to return true if they were able to
  /// handle the notification. Observers are notified in registration
  /// order until one returns true.
  ///
  /// This method exposes the `pushRoute` notification from
  // ignore: comment_references
  @override
  Future<bool> didPushRoute(String route) async {
    return super.didPushRoute(route);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocale(Locale locale) {
    super.didChangeLocale(locale);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system puts the app in the background or returns the app to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing these possible values:
    /// AppLifecycleState.paused (may enter the suspending state at any time)
    /// AppLifecycleState.resumed
    /// AppLifecycleState.inactive (may be paused at any time)
    /// AppLifecycleState.suspending (Android only)
    super.didChangeAppLifecycleState(state);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            I10n.t('You have pushed the button this many times:'),
            Text(con.data),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: App.themeData.primaryColor,
                  ),
                  child: CupertinoButton(
                    key: const Key('IncrementButton'),
                    onPressed: () {
                      setState(() {
                        con.onPressed();
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
