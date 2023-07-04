// Teste GIT
class Memory {
  static const operations = const ['%', '/', 'X', '-', '+', '=', 'Oskey'];
  String _value = '0';
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  bool _wipeValue = false;
  bool _newOperation = false;
  // bool _postOperation = false;
  String get value => _value;
  double total = 0;

  void applyCommand(String command) {
    if (command == 'Não Gostuei' || command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }
  }

  _allClear() {
    _buffer[0] = 0.0;
    _buffer[1] = 0.0;
    return _value = '0';
  }

  _setOperation(String newOperation) {
    _wipeValue = true;
    _newOperation = true;

    if (newOperation == '=' || newOperation == 'Oskey') {
      if (newOperation == '/') {
        total = _buffer[1] / _buffer[0];
        print(total);
        _value = total.toString();
      }
    }
  }

  _addDigit(String digit) {
    // final currentValue = _wipeValue ? '' : _value;
    // _value = currentValue + digit;
    // _wipeValue = false;
    String parseValue;

    _value = _wipeValue ? '' : _value;
    _wipeValue = false;

    if (_value.contains(',') && digit == ',') {
      return;
    }
    if ((_value == '0' || _value == '') && digit == ',') {
      _value = '0,';
      return;
    }
    if ((_value == '0' || _value == '') && digit == '0') {
      return;
    } else if ((_value == '0' || _value == '') && digit != '0') {
      _value = digit;
    } else {
      _value += digit;
    }
    parseValue = _value.contains(',') ? _value.split(',').join('.') : _value;

    _newOperation
        ? _buffer[_bufferIndex] = double.tryParse(parseValue) ?? 0
        : _buffer[1] = double.tryParse(parseValue) ?? 0;
    _newOperation = false;

    print(_buffer);
  }
}
