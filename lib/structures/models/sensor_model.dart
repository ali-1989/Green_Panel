
import 'package:app/system/keys.dart';
import 'package:iris_tools/dateSection/dateHelper.dart';

class SensorModel {
  late int id;
  late int mindId;
  late int sensorType;
  DateTime? registerDate;


  SensorModel();

  SensorModel.fromMap(Map map) {
    id = map[Keys.id];
    mindId = map['mind_id'];
    sensorType = map['sensor_type'];
    registerDate = DateHelper.timestampToSystem(map['register_date']);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map[Keys.id] = id;
    map['mind_id'] = mindId;
    map['register_date'] = registerDate;
    map['sensor_type'] = sensorType;

    return map;
  }
}
