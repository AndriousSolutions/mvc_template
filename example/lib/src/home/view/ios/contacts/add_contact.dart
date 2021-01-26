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

import 'package:starter_app/src/home/model/contacts/contact.dart';

class AddContact extends StatefulWidget {
  const AddContact({this.contact, this.title, Key key}) : super(key: key);
  final Contact contact;
  final String title;
  @override
  State createState() => _AddContactState();
}

class _AddContactState extends StateMVC<AddContact> {
  @override
  void initState() {
    super.initState();
    contact = widget.contact;
    // If adding a new contact.
    contact ??= Contact();
  }

  Contact contact;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Home',
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        middle: Text(widget.title ?? 'Add a contact'),
        trailing: Material(
          child: FlatButton(
            onPressed: () async {
              final pop = await contact.onPressed();
              if (pop) {
                await contact.model.getContacts();
                Navigator.of(context).pop();
              }
            },
            child: const Icon(Icons.save),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: contact.formKey,
          child: ListView(
            children: [
              contact.givenName.textFormField,
              contact.middleName.textFormField,
              contact.familyName.textFormField,
              contact.phone.onListItems(),
              contact.email.onListItems(),
              contact.company.textFormField,
              contact.jobTitle.textFormField,
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.title ?? 'Add a contact'),
  //       actions: [
  //         FlatButton(
  //           onPressed: () async {
  //             final pop = await contact.onPressed();
  //             if (pop) {
  //               Navigator.of(context).pop();
  //             }
  //           },
  //           child: const Icon(Icons.save, color: Colors.white),
  //         )
  //       ],
  //     ),
  //     body: Container(
  //       padding: const EdgeInsets.all(12),
  //       child: Form(
  //         key: contact.formKey,
  //         child: ListView(
  //           children: [
  //             contact.givenName.textFormField,
  //             contact.middleName.textFormField,
  //             contact.familyName.textFormField,
  //             contact.phone.onListItems(),
  //             contact.email.onListItems(),
  //             contact.company.textFormField,
  //             contact.jobTitle.textFormField,
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
