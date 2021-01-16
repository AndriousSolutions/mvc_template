///
/// Copyright (C) 2020 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  21 Apr 2020
///

class Model {
  /// Optional but, in most cases, you need only one instance of the Model class.
  ///
  factory Model() => _this ??= Model._();
  Model._();
  static Model _this;

  /// Note, this class extends no other class.
  /// It's to be used as your app's data source, and who knows what that will be.
  /// As part of the MVC architecture, it can be anything you want.
  /// The functions below are merely 'suggestions' as to the functionality
  /// this class should hold. In most cases, only a Controller will call such
  /// functions directly from the Model. The View and Model need not communicate.

  Future<bool> initAsync() async {
    bool init = true;
    return init;
  }

  void dispose() {}

  Future<List<dynamic>> getWhatever() async {
    var contacts = <dynamic>[];
    return contacts;
  }

  Future<bool> addWhatever() async {
    var add = true;
    return add;
  }

  Future<bool> saveWhatever() async {
    var save = true;
    return save;
  }

  Future<bool> deleteWhatever() async {
    var delete = true;
    return delete;
  }
}
