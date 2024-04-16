import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

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

  String _savedText = '';
  String get savedText => _savedText;
  set savedText(String _value) {
    _savedText = _value;
    prefs.setString('ff_savedText', _value);
  }

  List<String> _WholeCreatePageTest = [];
  List<String> get WholeCreatePageTest => _WholeCreatePageTest;
  set WholeCreatePageTest(List<String> _value) {
    _WholeCreatePageTest = _value;
    prefs.setStringList('ff_WholeCreatePageTest', _value);
  }

  void addToWholeCreatePageTest(String _value) {
    _WholeCreatePageTest.add(_value);
    prefs.setStringList('ff_WholeCreatePageTest', _WholeCreatePageTest);
  }

  void removeFromWholeCreatePageTest(String _value) {
    _WholeCreatePageTest.remove(_value);
    prefs.setStringList('ff_WholeCreatePageTest', _WholeCreatePageTest);
  }

  void removeAtIndexFromWholeCreatePageTest(int _index) {
    _WholeCreatePageTest.removeAt(_index);
    prefs.setStringList('ff_WholeCreatePageTest', _WholeCreatePageTest);
  }

  void updateWholeCreatePageTestAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _WholeCreatePageTest[_index] = updateFn(_WholeCreatePageTest[_index]);
    prefs.setStringList('ff_WholeCreatePageTest', _WholeCreatePageTest);
  }

  void insertAtIndexInWholeCreatePageTest(int _index, String _value) {
    _WholeCreatePageTest.insert(_index, _value);
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
