///
/// Copyright (C) 2018 Andrious Solutions
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  16 Dec 2018
///
///

import 'package:starter_app/src/view.dart';

import 'package:starter_app/src/app/controller/app_controller.dart'
    show Controller;

import 'add_contact.dart';

import 'contact_details.dart';

class ContactListState extends StateMVC<ContactsList> {
  ContactListState() : super(Controller()) {
    con = controller;
  }
  Controller con;

  @override
  void initState() {
    super.initState();
    _title = App.title;
  }

  String _title;

  /// The framework calls this method whenever it removes this [State] object
  /// from the tree.
  @override
  void deactivate() {
    super.deactivate();

    /// The framework calls this method whenever it removes this [State] object
    /// from the tree. It might reinsert it into another part of the tree.
    /// Subclasses should override this method to clean up any links between
    /// this object and other elements in the tree (e.g. if you have provided an
    /// ancestor with a pointer to a descendant's [RenderObject]).
  }

  /// The framework calls this method when this [State] object will never
  /// build again.
  /// Note: THERE IS NO GUARANTEE THIS METHOD WILL RUN in the Framework.
  @override
  void dispose() {
    super.dispose();
  }

  // ignore: comment_references
  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  /// Called when a dependency of this [State] object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called when the system puts the app in the background or returns the app to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    /// Passing these possible values:
    /// AppLifecycleState.paused (may enter the suspending state at any time)
    /// AppLifecycleState.resumed
    /// AppLifecycleState.inactive (may be paused at any time)
    /// AppLifecycleState.suspending (Android only)
  }

  @override
  Widget build(BuildContext context) {
    final _theme = App.themeData;
    return CupertinoPageScaffold(
//      key: con.scaffoldKey,
      child: CustomScrollView(
        semanticChildCount: 5,
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(_title ?? widget.title),
            leading: Material(
              child: IconButton(
                icon: const Icon(Icons.sort_by_alpha),
                onPressed: () {
                  con.sort();
                },
              ),
            ),
            middle: Material(
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute<void>(
                    builder: (BuildContext _) =>
                        InheritedTheme.captureAll(context, const AddContact()),
                  ));
                  //     .then((_) {
                  //   con.refresh();
                  // });
                },
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopMenu(context).popupMenuButton,
              ],
            ),
          ),
          if (con.items == null)
            const Center(child: CircularProgressIndicator())
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final contact = con.itemAt(index);
                  return contact.displayName.onDismissible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _theme.canvasColor,
                        border: Border(
                          bottom: BorderSide(color: _theme.dividerColor),
                        ),
                      ),
                      child: CupertinoListTile(
                        leading: contact.displayName.circleAvatar,
                        title: contact.displayName.text,
                        onTap: () {
                          final context = App.context;
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute<void>(
                            builder: (BuildContext _) =>
                                InheritedTheme.captureAll(
                                    context, ContactDetails(contact: contact)),
                          ));
                          //     .then((_) {
                          //   con.refresh();
                          // });
                        },
                      ),
                    ),
                    dismissed: (DismissDirection direction) {
                      con.deleteItem(index);
                      final action = (direction == DismissDirection.endToStart)
                          ? 'deleted'
                          : 'archived';
                      con.scaffoldKey.currentState?.showSnackBar(
                        SnackBar(
                          duration: const Duration(milliseconds: 8000),
                          content: Text('You $action an item.'),
                          action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () {
                                contact.undelete();
                                // ignore: cascade_invocations
                                //                               con.refresh();
                                refresh();
                              }),
                        ),
                      );
                    },
                  );
                },
                childCount: con.items.length,
                semanticIndexCallback: (Widget widget, int localIndex) {
                  if (localIndex.isEven) {
                    return localIndex ~/ 2;
                  }
                  return null;
                },
              ),
            ),
        ],
      ),
    );
  }
}
