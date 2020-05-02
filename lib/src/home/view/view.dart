

import 'package:mvc_template/src/view.dart';

class MyHome extends StatefulWidget {
  MyHome({Key key}) : super(key: key);
  // Produces an Android Interface or an iOS interface
  @override
  State createState() => App.useMaterial ? MyAndroid() : MyiOS();
}