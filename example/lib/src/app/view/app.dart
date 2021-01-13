import 'package:starter_app/src/view.dart';

import 'package:starter_app/src/controller.dart';

/// App
class MyApp extends AppStatefulWidget {
  MyApp({Key key}) : super(key: key);
  // This is the 'View' of the application.
  @override
  AppState createView() => MyView();
}

// This is the 'View' of the application. The 'look and feel' of the app.
class MyView extends AppState {
  MyView()
      : _con = Controller(),
        super(
          title: I10n.s('Starter App Example'),
          debugShowCheckedModeBanner: false,
          switchUI: Prefs.getBool('switchUI'),
        );
  final Controller _con;

  @override
  Widget onHome() {
    return _con.wordsApp
        ? WordPairs(key: AppState.homeKey)
        : HomePage(key: AppState.homeKey);
  }
}
