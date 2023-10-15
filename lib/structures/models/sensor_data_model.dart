
import 'package:app/system/keys.dart';
import 'package:iris_tools/dateSection/dateHelper.dart';

class SensorDataModel {
  late int sensorId;
  late Map data;
  DateTime? receiveDate;


  SensorDataModel();

  SensorDataModel.fromMap(Map map) {
    sensorId = map['sensor_id'];
    data = map[Keys.data];
    receiveDate = DateHelper.timestampToSystem(map['receive_date']);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['sensor_id'] = sensorId;
    map[Keys.data] = data;
    map['receive_date'] = receiveDate;

    return map;
  }
}
