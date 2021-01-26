import 'package:starter_app/src/view.dart';

import 'package:starter_app/src/home/view/android/contacts/contacts_list.dart'
    as a;

import 'package:starter_app/src/home/view/ios/contacts/contacts_list.dart' as i;

class ContactsList extends StatefulWidget {
  const ContactsList({Key key, this.title = 'Contacts App'}) : super(key: key);
  final String title;
  @override
  State createState() =>
      // ignore: no_logic_in_create_state
      App.useMaterial ? a.ContactListState() : i.ContactListState();
}
