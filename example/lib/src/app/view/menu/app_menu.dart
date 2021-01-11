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

import 'package:starter_app/src/model.dart';

import 'package:starter_app/src/view.dart';

import 'package:starter_app/src/controller.dart';

class PopMenu extends AppPopupMenu<String> {
  //
  factory PopMenu(
    BuildContext context, {
    Key key,
    List<String> items,
    PopupMenuItemBuilder<String> itemBuilder,
    String initialValue,
    PopupMenuItemSelected<String> onSelected,
    PopupMenuCanceled onCanceled,
    String tooltip,
    double elevation,
    EdgeInsetsGeometry padding,
    Widget child,
    Widget icon,
    Offset offset,
    bool enabled,
    ShapeBorder shape,
    Color color,
    // false so to prevent the error,
    // "Looking up a deactivated widget's ancestor is unsafe."
    bool captureInheritedThemes = false,
  }) {
    _context = context;
    _this ??= PopMenu._(
      key,
      items,
      itemBuilder,
      initialValue,
      onSelected,
      onCanceled,
      tooltip,
      elevation,
      padding,
      child,
      icon,
      offset,
      enabled,
      shape,
      color,
      captureInheritedThemes,
    );
    return _this;
  }

  PopMenu._(
    Key key,
    List<String> items,
    PopupMenuItemBuilder<String> itemBuilder,
    String initialValue,
    PopupMenuItemSelected<String> onSelected,
    PopupMenuCanceled onCanceled,
    String tooltip,
    double elevation,
    EdgeInsetsGeometry padding,
    Widget child,
    Widget icon,
    Offset offset,
    bool enabled,
    ShapeBorder shape,
    Color color,
    bool captureInheritedThemes,
  ) : super(
          key: key,
          items: items,
          itemBuilder: itemBuilder,
          initialValue: initialValue,
          onSelected: onSelected,
          onCanceled: onCanceled,
          tooltip: tooltip,
          elevation: elevation,
          padding: padding,
          child: child,
          icon: icon,
          offset: offset,
          enabled: enabled,
          shape: shape,
          color: color,
          captureInheritedThemes: captureInheritedThemes,
        ) {
    con = Controller();
  }
  static PopMenu _this;
  static BuildContext _context;
  Controller con;

  // Supply what the interface
  String get application => Prefs.getBool('words') ? 'Word Pairs' : 'Counter';

  String get interface => App.useMaterial ? 'Material' : 'Cupertino';

  @override
  Offset offset = Offset(0, 45);
  @override
  ShapeBorder shape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

  @override
  List<PopupMenuItem<String>> get menuItems => [
        PopupMenuItem(
            value: 'interface',
            child: Text('${I10n.s('Interface:')} $interface')),
        PopupMenuItem(
            value: 'application',
            child: Text('${I10n.s('Application:')} $application')),
        PopupMenuItem(
            value: 'locale',
            child: Text('${I10n.s('Locale:')} ${App.locale.toLanguageTag()}')),
        PopupMenuItem(value: 'color', child: I10n.t('Color Theme')),
        PopupMenuItem(value: 'about', child: I10n.t('About')),
      ];

  @override
  void onSelection(String value) async {
    switch (value) {
      case 'interface':
        con.changeUI();
        break;
      case 'application':
        var app = Prefs.getBool('words');
        Prefs.setBool('words', !app);
        App.refresh();
        break;
      case 'locale':
        final initialItem = I10n.supportedLocales.indexOf(App.locale);
        final spinner = ISOSpinner(initialItem: initialItem);

        await DialogBox(
          context: _context,
          title: I10n.s('Current Language'),
          body: [spinner],
          press01: () {
            spinner.onSelectedItemChanged(initialItem);
          },
          press02: () {},
          switchButtons: Settings.getLeftHanded(),
        ).show();
        break;
      case 'color':
        // Set the current colour.
        ColorPicker.color = App.themeData.primaryColor;

        ColorPicker.showColorPicker(
            context: _context,
            onColorChange: _onColorChange,
            onChange: _onChange,
            shrinkWrap: true);
        break;
      case 'about':
        showAboutDialog(
          context: _context,
          applicationName: App.vw.title ?? '',
          applicationVersion:
              'version: ${App.version} build: ${App.buildNumber}',
        );
        break;
      default:
    }
  }

  void _onColorChange(Color value) {
    /// Implement to take in a color change.
  }

  static void _onChange([ColorSwatch<int> value]) {
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

  /// Turn to the App's menu to set the App's theme.
  static void setThemeData() => _onChange();
}
