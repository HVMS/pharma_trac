import 'dart:async';

class VitalSignsBloc {
  final _heartRateController = StreamController<String>.broadcast();

  Stream<String> get heartRateStream => _heartRateController.stream;

  void updateHeartRate(String heartRateValue) {
    if (!_heartRateController.isClosed) {
      _heartRateController.sink.add(heartRateValue);
    }
  }

  void dispose() {
    _heartRateController.close();
  }
}

final vitalSignsBloc = VitalSignsBloc();
