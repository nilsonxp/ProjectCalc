// Teste GIT > Teste 3 >
class Memory {
  static const operations = ['%', '/', 'X', '-', '+', '=', 'Oskey'];
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
      _setOperation(command);
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
    return _value = '0';
  }

  // FUNÇÃO QUE RETORNA SE O VALOR TEM RESTO OU NÁO (INT / DOUBLE)
  String _doubleOrIntValue(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toString();
  }

  _setOperation(String newOperation) {
    _wipeValue = true;

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

    if (newOperation == '=' || newOperation == 'Oskey') {
      newOperation = _lastOperation;
      _lastOperation = '=';
      if (newOperation == '=') {
        print('chegou aqui?');
        return;
      }
    }

    switch (newOperation) {
      case '/':
        _total = _buffer[0] / _buffer[1];
        _value = _doubleOrIntValue(_total);
        _lastOperation = newOperation;
        _waitingNextOperation = false;
        break;
      case 'X':
        _total = _buffer[0] * _buffer[1];
        _value = _doubleOrIntValue(_total);
        _lastOperation = newOperation;
        _waitingNextOperation = false;
        break;
      case '-':
        _total = _buffer[0] - _buffer[1];
        _value = _doubleOrIntValue(_total);
        _lastOperation = newOperation;
        _waitingNextOperation = false;
        break;
      case '+':
        _total = _buffer[0] + _buffer[1];
        _value = _doubleOrIntValue(_total);
        _lastOperation = newOperation;
        _waitingNextOperation = false;
        break;
      case '=' || 'Oskey':
        print('apertou igual');
        _value = 'TO DO';
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
    parseValue = _value.contains(',') ? _value.split(',').join('.') : _value;

    _bufferIndex >= 1 ? _bufferIndex = 1 : 0;
    _buffer[_bufferIndex] = double.tryParse(parseValue) ?? 0;
  }
}
