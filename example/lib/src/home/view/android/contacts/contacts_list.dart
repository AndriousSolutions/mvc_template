///
/// Copyright (C) 2018 Andrious Solutions
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

  @override
  Widget build(BuildContext context) {
    final _theme = App.themeData;
    return Theme(
      data: _theme,
      child: Scaffold(
//        key: con.scaffoldKey,
        appBar: AppBar(
          title: Text(_title ?? widget.title),
          actions: [
            FlatButton(
              onPressed: () {
                con.sort();
              },
              child: const Icon(Icons.sort_by_alpha, color: Colors.white),
            ),
            PopMenu(context).popupMenuButton,
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: _theme.primaryColor,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute<void>(
              builder: (BuildContext _) =>
                  InheritedTheme.captureAll(context, const AddContact()),
            ))
                .then((_) {
              con.refresh();
            });
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: con.items == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: con.items?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final contact = con.itemAt(index);
                    return contact.displayName.onDismissible(
                      child: Container(
                        decoration: BoxDecoration(
                            color: _theme.canvasColor,
                            border: Border(
                                bottom:
                                    BorderSide(color: _theme.dividerColor))),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (BuildContext _) =>
                                  InheritedTheme.captureAll(context,
                                      ContactDetails(contact: contact)),
                            ));
                            //     .then((_) {
                            //   con.refresh();
                            // });
                          },
                          leading: contact.displayName.circleAvatar,
                          title: contact.displayName.text,
                        ),
                      ),
                      dismissed: (DismissDirection direction) {
                        con.deleteItem(index);
                        final action =
                            (direction == DismissDirection.endToStart)
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
//                                  con.refresh();
                                  refresh();
                                }),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
