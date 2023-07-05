// Teste GIT > Teste 3 >
class Memory {
  static const operations = ['%', '/', 'X', '-', '+'];
  static const equal = ['=', 'Oskey'];
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  double _total = 0;
  String _value = '0';
  String _lastOperation = '=';
  bool _wipeValue = false;
  bool _waitingNextOperation = true;

  String get value => _value;

  void applyCommand(String command) {
    if (command == 'Não Gostuei' || command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      if (command == '%') {
        print('%');
        _wipeValue = true;
        _total = double.tryParse(_value)! / 100;
        _value = _total.toString();
        _buffer[_bufferIndex] = double.tryParse(_value)!;
      } else {
        _setOperation(command);
      }
    } else if (equal.contains(command)) {
      _bufferIndex == 0 ? _bufferIndex = 0 : _setOperation(_lastOperation);
    } else {
      _addDigit(command);
    }
  }

  _allClear() {
    _buffer[0] = 0.0;
    _buffer[1] = 0.0;
    _bufferIndex = 0;
    _waitingNextOperation = false;
    _lastOperation = '=';
    _value = '0';
  }

  // FUNÇÃO QUE RETORNA SE O VALOR TEM RESTO OU NÁO (INT / DOUBLE)
  String _doubleOrIntValue(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toString();
  }

  _setOperation(String newOperation) {
    _wipeValue = true;
    String changeOperation;

    if (_bufferIndex == 0) {
      _bufferIndex++;
      _lastOperation = newOperation;
      _waitingNextOperation = false;
      return;
    }

    if (!_waitingNextOperation) {
      _lastOperation = newOperation;
      return;
    }

    if (newOperation != _lastOperation) {
      changeOperation = newOperation;
      newOperation = _lastOperation;
      _lastOperation = changeOperation;
    }

    switch (newOperation) {
      case '/':
        _total = _buffer[0] / _buffer[1];
        _value = _doubleOrIntValue(_total);
        _waitingNextOperation = false;
        break;
      case 'X':
        _total = _buffer[0] * _buffer[1];
        _value = _doubleOrIntValue(_total);
        _waitingNextOperation = false;
        break;
      case '-':
        _total = _buffer[0] - _buffer[1];
        _value = _doubleOrIntValue(_total);
        _waitingNextOperation = false;
        break;
      case '+':
        _total = _buffer[0] + _buffer[1];
        _value = _doubleOrIntValue(_total);
        _waitingNextOperation = false;
        break;
    }

    _buffer[0] = double.tryParse(_value)!;
  }

  _addDigit(String digit) {
    String parseValue;

    _value = _wipeValue ? '' : _value;
    _wipeValue = false;
    _waitingNextOperation = true;

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
    parseValue = _value.contains(',') ? _value.replaceAll(',', '.') : _value;

    _bufferIndex >= 1 ? _bufferIndex = 1 : 0;
    _buffer[_bufferIndex] = double.tryParse(parseValue) ?? 0;
  }
}
