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

import 'package:starter_app/src/home/model/random_words.dart';

class RandomWordsAndroid extends StateMVC<WordPairs> {
  //
  RandomWordsAndroid() : super(Controller()) {
    con = controller;
  }
  Controller con;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    _title = App.title;
  }

  String _title;
  Model model;

  @override
  Widget build(BuildContext context) {
    // registered with the State object.
    add(model);
    return Scaffold(
      appBar: AppBar(
        title: Text(_title ?? widget.title),
        actions: [
          IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          PopMenu(context).popupMenuButton,
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, i) {
            if (i.isOdd) {
              return const Divider();
            }
            model.build(i);
            return ListTile(
              title: Text(
                model.data,
                style: const TextStyle(fontSize: 25),
              ),
              trailing: model.trailing,
              // onTap: () {
              //   setState(() {
              //     model.onTap(i);
              //   });
              // },
              onTap: () {
                model.onTap(i);
              },
            );
          }),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = model.tiles();
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
