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

import 'contact.dart' show Contact;

/// Add to the class this:
/// `extends FieldWidgets<T> with FieldChange`
mixin FormFields on FieldWidgets<Contact> {
  //
  Set<FieldWidgets<Contact>> get changedFields => _changedFields;
  static final Set<FieldWidgets<Contact>> _changedFields = {};

  /// If the field's value changed, that field is added to a Set.
  @override
  void onSaved(dynamic v) {
    super.onSaved(v);
    if (isChanged()) {
      _changedFields.add(this);
    }
  }

  bool changeIn<T>() => changedFields.whereType<T>().isNotEmpty;
}

class Id extends FieldWidgets<Contact> with FormFields {
  Id(dynamic value) : super(label: 'Identifier', value: value);
}

String notEmpty(String v) => v.isEmpty ? 'Cannot be empty' : null;

FormFields displayName(Contact contact) {
  String display;

  if (contact.givenName.value != null) {
    display = contact.givenName.value ?? '';
    display = '$display ${contact.familyName.value}';
  }
  display ??= '';

  return DisplayName(display, Text(display));
}

class DisplayName extends FieldWidgets<Contact> with FormFields {
  DisplayName(String value, Widget child)
      : super(
          label: 'Display Name',
          value: value,
          child: child,
        );
}

class GivenName extends FieldWidgets<Contact> with FormFields {
  GivenName([dynamic value])
      : super(
          label: 'First Name',
          value: value,
          validator: notEmpty,
          keyboardType: TextInputType.name,
        );
}

class MiddleName extends FieldWidgets<Contact> with FormFields {
  MiddleName([dynamic value])
      : super(
          label: 'Middle Name',
          value: value,
          keyboardType: TextInputType.name,
        );
}

class FamilyName extends FieldWidgets<Contact> with FormFields {
  FamilyName([dynamic value])
      : super(
          label: 'Last Name',
          value: value,
          validator: notEmpty,
          keyboardType: TextInputType.name,
        );
}

class Company extends FieldWidgets<Contact> with FormFields {
  Company([dynamic value])
      : super(
          label: 'Company',
          value: value,
          keyboardType: TextInputType.name,
        );
}

class JobTitle extends FieldWidgets<Contact> with FormFields {
  JobTitle([dynamic value])
      : super(
          label: 'Job',
          value: value,
          keyboardType: TextInputType.name,
        );
}

class Phone extends FieldWidgets<Contact> with FormFields {
  //
  Phone([dynamic value])
      : super(
          label: 'Phone',
          value: value,
          inputDecoration: const InputDecoration(labelText: 'Phone'),
          keyboardType: TextInputType.phone,
        ) {
    // Change the name of the map's key fields.
    keys(value: 'phone');
    // There may be more than one phone number
    one2Many<Phone>(() => Phone());
  }

  Phone.init(DataFieldItem dataItem)
      : super(
          label: dataItem.label,
          value: dataItem.value,
          type: dataItem.type,
        );

  @override
  ListItems<Contact> onListItems({
    String title,
    List<FieldWidgets<Contact>> items,
    MapItemFunction mapItem,
    GestureTapCallback onTap,
    ValueChanged<String> onChanged,
    List<String> dropItems,
  }) =>
      super.onListItems(
        title: title,
        items: items,
        mapItem: mapItem,
        onTap: onTap,
        onChanged: onChanged ?? (String value) => App.refresh(),
        dropItems:
            dropItems ?? const ['home', 'work', 'landline', 'modile', 'other'],
      );
}

class Email extends FieldWidgets<Contact> with FormFields {
  Email([dynamic value])
      : super(
          label: 'Email',
          value: value,
          inputDecoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ) {
    // There may be more than one email address.
    one2Many<Email>(() => Email());
  }

  Email.init(DataFieldItem dataItem)
      : super(
          label: dataItem.label,
          value: dataItem.value,
          type: dataItem.type,
        );

  @override
  ListItems<Contact> onListItems({
    String title,
    List<FieldWidgets<Contact>> items,
    MapItemFunction mapItem,
    GestureTapCallback onTap,
    ValueChanged<String> onChanged,
    List<String> dropItems,
  }) =>
      super.onListItems(
        title: title,
        items: items,
        mapItem: mapItem,
        onTap: onTap,
        dropItems: dropItems ?? ['home', 'work', 'other'],
        onChanged: onChanged ??
            (String value) {
              App.refresh();
            },
      );
}
