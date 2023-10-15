
import 'package:app/system/keys.dart';
import 'package:iris_tools/dateSection/dateHelper.dart';

class SyncModel {
  late int id;
  late String serialNumber;
  late int mindId;
  int? firmwareVersion;
  DateTime? productDate;
  DateTime? registerDate;

  Map? states;

  SyncModel();

  SyncModel.fromMap(Map map) {
    id = map[Keys.id];
    mindId = map['mind_id'];
    serialNumber = map['serial_number'];
    productDate = DateHelper.timestampToSystem(map['product_date']);
    registerDate = DateHelper.timestampToSystem(map['register_date']);
    states = map['devices_state'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map[Keys.id] = id;
    map['serial_number'] = serialNumber;
    map['mind_id'] = mindId;
    map['register_date'] = registerDate;
    map['product_date'] = productDate;
    map['devices_state'] = states;

    return map;
  }
}
