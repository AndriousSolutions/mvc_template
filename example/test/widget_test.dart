// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:starter_app/src/home/model/words/random_words.dart';

import 'package:starter_app/src/view.dart';

import 'package:starter_app/src/controller.dart';

/// A flag to ensure any errors are caught when appropriate.
bool _inError = false;
String _errorMessage = '';

void main() {
  testWidgets(
    'MVC_Template Tester',
    (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      await tester.pumpAndSettle();

      final con = Controller();

      try {
        //
        if (App.useCupertino) {
          /// Switch to Material
          await openInterfaceMenu(tester);
        }
//      /// Change the app's color theme
//      await testColorTheme(tester);

        if (!con.wordsApp) {
          con.changeApp('Word Pairs');
          await tester.pumpAndSettle();
        }

        if (con.wordsApp) {
          /// Random Word Pairs app
          await wordsTest(tester);
        } else {
          /// Counter app testing
          await counterTest(tester);
        }
      } catch (error) {
        _catchError(error);
      }

      try {
        /// Switch the application.
        con.changeApp('Counter');
        await tester.pumpAndSettle();
        // /// Switch the application.
        // await openApplicationMenu(tester);

        if (con.wordsApp) {
          /// Random Word Pairs app
          await wordsTest(tester);
        } else {
          /// Counter app testing
          await counterTest(tester);
        }
      } catch (error) {
        _catchError(error);
      }

      await menuTest(tester);

      /// Report any errors.
      _reportErrors();
    },
  );
}

/// Counter app testing
Future<void> counterTest(WidgetTester tester) async {
  // Verify that our counter starts at 0.
  expect(find.text('0'), findsOneWidget);
  expect(find.text('1'), findsNothing);

  final finder =
      find.byKey(const Key('IncrementButton')); // find.byIcon(Icons.add)

  expect(finder, findsOneWidget);

  // Tap the '+' icon and trigger a frame.
  await tester.tap(finder);
  await tester.pump();

  // Verify that our counter has incremented.
  expect(find.text('0'), findsNothing);
  expect(find.text('1'), findsOneWidget);
}

/// Random Word Pairs app
Future<void> wordsTest(WidgetTester tester) async {
  //
  Finder finder;

  if (App.useMaterial) {
    // Find a list of word pairs
    finder = find.byType(ListTile);
  } else {
    finder = find.byType(CupertinoListTile);
  }

  expect(finder, findsWidgets);

  if (App.useCupertino) {
    return;
  }

  // Tap the first three
  if (App.useMaterial) {
    await tester.tap(finder.first);

    await tester.tap(finder.at(1));

    await tester.tap(finder.at(2));
  } else {
    await tester.tapAt(tester.getTopRight(finder.first));

    await tester.tapAt(tester.getTopRight(finder.at(1)));

    await tester.tapAt(tester.getTopRight(finder.at(2)));
  }

  // Go to the 'Saved Suggestions' page.
  finder = find.byKey(const Key('listSaved')); //find.byType(IconButton);

  expect(finder, findsWidgets);

  await tester.tap(finder.first);

  // Rebuild the widget after the state has changed.
  await tester.pumpAndSettle();

  expect(find.text('Saved Suggestions'), findsOneWidget);

  final Model model = Model();

  // Successfully saved the selected word pairs.
  if (!model.saved.isNotEmpty) {
    fail('Failed to list saved suggestions.');
  } else {
    expect(model.saved.length, equals(3));
  }

  // Find the 'back button' and return
  await tester.tap(find.byType(IconButton).first);

  // Rebuild the widget after the state has changed.
  await tester.pump();
}

///
Future<void> menuTest(WidgetTester tester) async {
  /// Open the Locale window.
  await openLocaleMenu(tester);

  /// Open Color menu.
  await openColorMenu(tester);

  /// Open About menu.
  await openAboutMenu(tester);

  /// Switch the application.
  await openApplicationMenu(tester);

  /// Switch explicitly to Counter app.
  Controller().changeApp('Counter');

  /// Switch the Interface.
  await openInterfaceMenu(tester);
}

/// Open the PopupMenu
Future<bool> openPopupMenu(WidgetTester tester) async {
  bool opened = true;
  try {
    final popup = find.byKey(const Key('appMenuButton'));
    expect(popup, findsOneWidget);
    await tester.tap(popup);
    await tester.pump(const Duration(seconds: 1));
  } catch (error) {
    opened = false;
    _catchError(error);
  }
  return opened;
}

Future<bool> openInterfaceMenu(WidgetTester tester) async {
  /// Open popup menu.
  bool tested = await openPopupMenu(tester);
  if (!tested) {
    return tested;
  }

  try {
    /// Switch the Interface.
    final interface = find.byKey(const Key('interfaceMenuItem'));
    expect(interface, findsOneWidget);
    await tester.tap(interface);
    await tester.pump(const Duration(seconds: 1));
  } catch (error) {
    tested = false;
    _catchError(error);
  }
  return tested;
}

Future<bool> openApplicationMenu(WidgetTester tester) async {
  /// Open popup menu.
  bool tested = await openPopupMenu(tester);
  if (!tested) {
    return tested;
  }

  try {
    /// Switch the application.
    final application = find.byKey(const Key('applicationMenuItem'));
    expect(application, findsOneWidget);
    await tester.tap(application);
    await tester.pump(const Duration(seconds: 1));
  } catch (error) {
    tested = false;
  }
  return tested;
}

Future<bool> openLocaleMenu(WidgetTester tester) async {
  /// Open popup menu.
  bool tested = await openPopupMenu(tester);
  if (!tested) {
    return tested;
  }

  try {
    /// Open the Locale window.
    final locale = find.byKey(const Key('localeMenuItem'));
    expect(locale, findsOneWidget);
    await tester.tap(locale);
    await tester.pump(const Duration(seconds: 1));

    /// Close window.
    final button = find.widgetWithText(SimpleDialogOption, 'Cancel');
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump(const Duration(seconds: 1));
  } catch (error) {
    tested = false;
    _catchError(error);
  }
  return tested;
}

Future<bool> openColorMenu(WidgetTester tester) async {
  /// Open popup menu.
  bool tested = await openPopupMenu(tester);
  if (!tested) {
    return tested;
  }

  try {
    /// Open the Color window.
    final color = find.byKey(const Key('colorMenuItem'));
    expect(color, findsOneWidget);
    await tester.tap(color);
    await tester.pump(const Duration(seconds: 1));

    ///Close window
    await tester.tapAt(const Offset(0, 0));
    await tester.pump(const Duration(seconds: 1));
  } catch (error) {
    tested = false;
    _catchError(error);
  }
  return tested;
}

Future<bool> openAboutMenu(WidgetTester tester) async {
  /// Open popup menu.
  bool tested = await openPopupMenu(tester);
  if (!tested) {
    return tested;
  }

  try {
    /// Open the About window.
    final about = find.byKey(const Key('aboutMenuItem'));
    expect(about, findsOneWidget);
    await tester.tap(about);
    await tester.pump(const Duration(seconds: 1));

    /// Close window.
    final button = find.widgetWithText(TextButton, 'CLOSE');
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump(const Duration(seconds: 1));
  } catch (error) {
    tested = false;
    _catchError(error);
  }
  return tested;
}

mixin VariantTester<T> on TestVariant<T> {
  // Determine the current value;
  T currentValue;

  // Assign the current value in case describeValue() was overridden.
  @override
  @mustCallSuper
  Future<Object> setUp(T value) async {
    currentValue = value;
    return null;
  }
}

void _catchError(Object error) {
  _inError = true;
  _errorMessage = '$_errorMessage${error.toString()} \r\n';
}

/// Throw any collected errors
void _reportErrors() {
  if (_inError) {
    throw Exception(_errorMessage);
  }
}

/// Unit Test of the Color Theme mechanism.
Future<void> testColorTheme(WidgetTester tester) async {
  // Supply a list of colors to the app.
  const List<ColorSwatch<int>> fullMaterialColors = [
    ColorSwatch(0xFFFFFFFF, {500: Colors.white}),
    ColorSwatch(0xFF000000, {500: Colors.black}),
    Colors.red,
    Colors.redAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.teal,
    Colors.tealAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.lime,
    Colors.limeAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.amber,
    Colors.amberAccent,
    Colors.orange,
    Colors.orangeAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey
  ];

  final con = Controller();

  for (final color in fullMaterialColors) {
    con.onColorPicker(color);
    await tester.pump(const Duration(milliseconds: 500));
  }
}
