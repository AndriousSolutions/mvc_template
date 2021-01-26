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

import 'package:starter_app/src/view.dart' hide HomePage;

import 'package:starter_app/src/home/view/my_first_flutter_app.dart';

import 'package:starter_app/src/controller.dart';

import 'package:starter_app/src/home/model/words/random_words.dart';

class RandomWordsiOS extends StateMVC<WordPairs> {
  //
  RandomWordsiOS() : super(Controller()) {
    con = controller;
  }
  Controller con;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    _title = App.title;
  }

  // The 'data source' for the app.
  Model model;
  String _title;

  @override
  Widget build(BuildContext context) {
    // Register the 'controller' again and again if switched by UI.
    add(model);
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(_title ?? widget.title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  key: const Key('listSaved'),
                  onPressed: _pushSaved,
                  child: const Icon(Icons.list),
                ),
                PopMenu(context).popupMenuButton,
              ],
            ),
          ),
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.only(top: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  if (i.isOdd) {
                    return const Divider();
                  }
                  model.build(i);
                  return CupertinoListTile(
                    title: Text(model.title),
                    trailing: model.trailing,
                    onTap: () {
                      model.onTap(i);
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<Widget> tiles = model.tiles();
          final Iterator<Widget> it = tiles.iterator;
          it.moveNext();
          return CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                const CupertinoSliverNavigationBar(
                  largeTitle: Text('Saved Suggestions'),
                ),
                SliverSafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(top: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final tile = it.current;
                        it.moveNext();
                        return tile;
                      },
                      childCount: tiles.length,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
