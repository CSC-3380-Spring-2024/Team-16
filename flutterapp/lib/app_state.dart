import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodappproject/app_data.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _savedText = prefs.getString('ff_savedText') ?? _savedText;
    });
    _safeInit(() {
      _WholeCreatePageTest =
          prefs.getStringList('ff_WholeCreatePageTest') ?? _WholeCreatePageTest;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  //MARK: Test Fridge Data
  List<FridgeData> containers = [FridgeData(
    name: "TESTFRIDGE",
    icon: Icons.access_alarm_outlined,
    color: PresetColor.yellow,
    temperature: 69.8,
    contents: [IngredientData(name: "Banana", quantity: "1 qt", expiry: 4)],
    )
  ];
  ////////////////////////////////////////////////////
  
  String _savedText = '';
  String get savedText => _savedText;
  set savedText(String value) {
    _savedText = value;
    prefs.setString('ff_savedText', value);
  }

  List<String> _WholeCreatePageTest = [];
  List<String> get WholeCreatePageTest => _WholeCreatePageTest;
  set WholeCreatePageTest(List<String> value) {
    _WholeCreatePageTest = value;
    prefs.setStringList('ff_WholeCreatePageTest', value);
  }

  void addToWholeCreatePageTest(String value) {
    _WholeCreatePageTest.add(value);
    prefs.setStringList('ff_WholeCreatePageTest', _WholeCreatePageTest);
  }

  void removeFromWholeCreatePageTest(String value) {
    _WholeCreatePageTest.remove(value);
    prefs.setStringList('ff_WholeCreatePageTest', _WholeCreatePageTest);
  }

  void removeAtIndexFromWholeCreatePageTest(int index) {
    _WholeCreatePageTest.removeAt(index);
    prefs.setStringList('ff_WholeCreatePageTest', _WholeCreatePageTest);
  }

  void updateWholeCreatePageTestAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _WholeCreatePageTest[index] = updateFn(_WholeCreatePageTest[index]);
    prefs.setStringList('ff_WholeCreatePageTest', _WholeCreatePageTest);
  }

  void insertAtIndexInWholeCreatePageTest(int index, String value) {
    _WholeCreatePageTest.insert(index, value);
    prefs.setStringList('ff_WholeCreatePageTest', _WholeCreatePageTest);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
