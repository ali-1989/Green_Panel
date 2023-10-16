import 'package:app/managers/settings_manager.dart';
import 'package:app/structures/middleWares/requester.dart';
import 'package:app/structures/models/sensor_data_model.dart';
import 'package:app/structures/models/sensor_model.dart';
import 'package:app/structures/models/sight_model.dart';
import 'package:app/structures/models/sync_model.dart';
import 'package:app/system/extensions.dart';
import 'package:app/system/keys.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_icons.dart';
import 'package:app/tools/app/app_snack.dart';
import 'package:app/tools/date_tools.dart';
import 'package:flutter/material.dart';

import 'package:app/structures/abstract/state_super.dart';
import 'package:iris_tools/api/converter.dart';
import 'package:iris_tools/api/helpers/mathHelper.dart';
import 'package:iris_tools/dateSection/dateHelper.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}
///=============================================================================
class HomePageState extends StateSuper<HomePage> {
  String url = '${SettingsManager.localSettings.httpAddress}/test';
  ScrollController scrollCtr = ScrollController();
  List<Map> greenMindList = [];
  List<SightModel> greenSightList = [];
  List<SyncModel> greenSyncList = [];
  List<SensorModel> sensorList = [];
  List<SensorDataModel> currentSensorDataList = [];

  TextEditingController sensorIdCtr = TextEditingController();


  @override
  void initState(){
    super.initState();

    requestGreenMind();
    requestGreenSight();
    requestGreenSync();
    requestSensors();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody(){
    return Scrollbar(
      thumbVisibility: true,
      controller: scrollCtr,
      child: ListView(
        controller: scrollCtr,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 30),
          Center(child: const Text('Green house').bold().fsR(3)),

          const SizedBox(height: 30),
          const Text('Notes:').bold(),
          Row(
            children: [
              const Text('  All '),
              const Text('methods').bold(),
              const Text(' are '),
              const Text('POST').bold(),
              const Text(' and all '),
              const Text('formats').bold(),
              const Text(' are '),
              const Text('json').bold(),
            ],
          ),

          const SizedBox(height: 30),
          const Text('Sample of JSON:').bold(),
          const SelectableText('{ "request": "register_green_mind",  "serial_number": "abcdef",  "product_date": "2023-10-11" }'),

          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 12),

          buildRegisterGreenMind(),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),

          buildRegisterGreenSight(),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),

          buildRegisterGreenSync(),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),

          buildRegisterSensor(),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),

          buildRegisterSensorData(),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget buildRegisterGreenMind() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Registering Green Mind').bold().color(AppDecoration.mainColor),
        const SizedBox(height: 20),
        SelectableText('URL: $url'),

        const SizedBox(height: 5),
        Row(
          children: [
            const Text('request key: ').bold(),
            const Text('register_green_mind'),
          ],
        ),

        Row(
          children: [
            const Text('required fields: ').bold(),
            const Text('serial_number'),
          ],
        ),

        Row(
          children: [
            const Text('optional fields: ').bold(),
            const Text('product_date,  firmware_version'),
          ],
        ),

        const Text('response: {"status": "ok",  "id" : "a mind id"}'),

        IconButton(
            onPressed: requestGreenMind,
            icon: const Icon(AppIcons.refresh)
        ),
        
        DataTable(
          border: TableBorder.all(color: Colors.black54, width: 1),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('SN')),
              DataColumn(label: Text('firmware')),
              DataColumn(label: Text('register date')),
              DataColumn(label: Text('product date')),
              DataColumn(label: Text('active date')),
            ],
            rows: [
              ...generateGreenMindRows(),
            ],
        )
      ],
    );
  }

  Widget buildRegisterGreenSight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Registering Green Sight').bold().color(AppDecoration.mainColor),
        const SizedBox(height: 20),
        SelectableText('URL: $url'),

        const SizedBox(height: 5),
        Row(
          children: [
            const Text('request key: ').bold(),
            const Text('register_green_sight'),
          ],
        ),

        Row(
          children: [
            const Text('required fields: ').bold(),
            const Text('serial_number,  mind_id'),
          ],
        ),

        Row(
          children: [
            const Text('optional fields: ').bold(),
            const Text('product_date,  firmware_version'),
          ],
        ),

        const Text('response: {"status": "ok",  "id" : "a sight id"}'),

        IconButton(
            onPressed: requestGreenSight,
            icon: const Icon(AppIcons.refresh)
        ),

        DataTable(
          border: TableBorder.all(color: Colors.black54, width: 1),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('SN')),
              DataColumn(label: Text('mind')),
              DataColumn(label: Text('firmware')),
              DataColumn(label: Text('register date')),
              DataColumn(label: Text('product date')),
            ],
            rows: [
              ...generateGreenSightRows(),
            ],
        )
      ],
    );
  }

  Widget buildRegisterGreenSync() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Registering Green Sync').bold().color(AppDecoration.mainColor),
        const SizedBox(height: 20),
        SelectableText('URL: $url'),

        const SizedBox(height: 5),
        Row(
          children: [
            const Text('request key: ').bold(),
            const Text('register_green_sync'),
          ],
        ),

        Row(
          children: [
            const Text('required fields: ').bold(),
            const Text('serial_number,  mind_id'),
          ],
        ),

        Row(
          children: [
            const Text('optional fields: ').bold(),
            const Text('product_date,  firmware_version'),
          ],
        ),

        const Text('response: {"status": "ok",  "id" : "a sync id"}'),

        IconButton(
            onPressed: requestGreenSync,
            icon: const Icon(AppIcons.refresh)
        ),

        DataTable(
          border: TableBorder.all(color: Colors.black54, width: 1),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('SN')),
              DataColumn(label: Text('mind')),
              DataColumn(label: Text('firmware')),
              DataColumn(label: Text('register date')),
              DataColumn(label: Text('product date')),
            ],
            rows: [
              ...generateGreenSyncRows(),
            ],
        )
      ],
    );
  }

  Widget buildRegisterSensor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Registering Sensor').bold().color(AppDecoration.mainColor),
        const SizedBox(height: 20),
        SelectableText('URL: $url'),


        const SizedBox(height: 5),
        Row(
          children: [
            const Text('request key: ').bold(),
            const Text('register_sensor'),
          ],
        ),

        Row(
          children: [
            const Text('required fields: ').bold(),
            const Text('sensor_type,  mind_id'),
          ],
        ),

        Row(
          children: [
            const Text('optional fields: ').bold(),
            const Text('product_date,  firmware_version'),
          ],
        ),

        const Text('response: {"status": "ok",  "id" : "a sensor id"}'),


        IconButton(
            onPressed: requestSensors,
            icon: const Icon(AppIcons.refresh)
        ),

        DataTable(
          border: TableBorder.all(color: Colors.black54, width: 1),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('mind')),
              DataColumn(label: Text('sensor type')),
              DataColumn(label: Text('register date')),
            ],
            rows: [
              ...generateSensorRows(),
            ],
        )
      ],
    );
  }

  Widget buildRegisterSensorData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('add Sensor data').bold().color(AppDecoration.mainColor),
        const SizedBox(height: 20),
        SelectableText('URL: $url'),

        const SizedBox(height: 5),
        Row(
          children: [
            const Text('request key: ').bold(),
            const Text('set_sensor_data'),
          ],
        ),

        Row(
          children: [
            const Text('required fields: ').bold(),
            const Text('sensor_id,  data'),
          ],
        ),

        Row(
          children: [
            const Text('optional fields: ').bold(),
            const Text('not have'),
          ],
        ),

        const Text('response: { "status": "ok" }'),

        const SizedBox(height: 12),

        Row(
          children: [
            const Text('Sensor ID: '),

            SizedBox(
              width: 100,
                child: TextField(
                  controller: sensorIdCtr,
                  decoration: AppDecoration.outlineBordersInputDecoration.copyWith(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(10),
                  ),
                )
            ),

            const SizedBox(width: 20),

            ElevatedButton(
                onPressed: (){
                  final id = MathHelper.clearToInt(sensorIdCtr.text.trim());

                  if(id < 1){
                    AppSnack.showInfo(context, 'please enter sensor ID');
                    return;
                  }

                  requestSensorData(id);
                },
                child: const Text('Get sensor data')
            ),
          ],
        ),

        DataTable(
          border: TableBorder.all(color: Colors.black54, width: 1),
            columns: const [
              DataColumn(label: Text('Sensor ID')),
              DataColumn(label: Text('receive date')),
              DataColumn(label: Text('data')),
            ],
            rows: [
              ...generateSensorDataRows(),
            ],
        )
      ],
    );
  }

  List generateGreenMindRows(){
    List<DataRow> ret = [];
    List<String> keys = ['id', 'serial_number', 'firmware_version', 'register_date', 'product_date',  'communication_date'];

    for(final x in greenMindList){
      List<DataCell> cells = [];

      for(final k in keys){
        for (final i in x.entries) {
          if(i.key == k){
            dynamic d = i.value;

            if(k.contains('_date')) {
              d = DateTools.dateOnlyRelative(DateHelper.timestampToSystem(d));
            }

            cells.add(DataCell(Text('$d')));
            break;
          }
        }
      }

      ret.add(DataRow(cells: cells));
    }

    return ret;
  }

  List generateGreenSightRows(){
    List<DataRow> ret = [];

    for(final x in greenSightList) {
      List<DataCell> cells = [];
      List items = [];

      items.add(x.id);
      items.add(x.serialNumber);
      items.add(x.mindId);
      items.add(x.firmwareVersion?? '');
      items.add(DateTools.dateOnlyRelative(x.productDate));
      items.add(DateTools.dateOnlyRelative(x.registerDate));

      for(final k in items) {
        cells.add(DataCell(Text('$k')));
      }

      ret.add(DataRow(cells: cells));
    }

    return ret;
  }

  List generateGreenSyncRows(){
    List<DataRow> ret = [];

    for(final x in greenSyncList) {
      List<DataCell> cells = [];
      List items = [];

      items.add(x.id);
      items.add(x.serialNumber);
      items.add(x.mindId);
      items.add(x.firmwareVersion?? '');
      items.add(DateTools.dateOnlyRelative(x.productDate));
      items.add(DateTools.dateOnlyRelative(x.registerDate));

      for(final k in items) {
        cells.add(DataCell(Text('$k')));
      }

      ret.add(DataRow(cells: cells));
    }

    return ret;
  }

  List generateSensorRows(){
    List<DataRow> ret = [];

    for(final x in sensorList) {
      List<DataCell> cells = [];
      List items = [];

      items.add(x.id);
      items.add(x.mindId);
      items.add(x.sensorType);
      items.add(DateTools.dateOnlyRelative(x.registerDate));

      for(final k in items) {
        cells.add(DataCell(Text('$k')));
      }

      ret.add(DataRow(cells: cells));
    }

    return ret;
  }

  List generateSensorDataRows(){
    List<DataRow> ret = [];

    for(final x in currentSensorDataList) {
      List<DataCell> cells = [];
      List items = [];

      items.add(x.sensorId);
      items.add(DateTools.dateOnlyRelative(x.receiveDate));
      items.add(x.data);

      for(final k in items) {
        cells.add(DataCell(Text('$k')));
      }

      ret.add(DataRow(cells: cells));
    }

    return ret;
  }

  void requestGreenMind() {
    final r = Requester();
    r.httpItem.method = 'POST';
    r.httpItem.fullUrl = url;
    r.bodyJson = {};
    r.bodyJson!['request'] = 'get_green_minds';

    r.httpRequestEvents.onAnyState = (res) async {
      if(res.isOk){
        Map r = res.getBodyAsJson()!;
        greenMindList = Converter.correctList(r[Keys.data])!;

        setState(() {});
      }

      return null;
    };

    r.request();
  }

  void requestGreenSight() {
    final r = Requester();
    r.httpItem.method = 'POST';
    r.httpItem.fullUrl = url;
    r.bodyJson = {};
    r.bodyJson!['request'] = 'get_green_sights';

    r.httpRequestEvents.onAnyState = (res) async {
      if(res.isOk){
        Map r = res.getBodyAsJson()!;

        for(final k in r[Keys.data]){
          greenSightList.add(SightModel.fromMap(k));
        }

        setState(() {});
      }

      return null;
    };

    r.request();
  }

  void requestGreenSync() {
    final r = Requester();
    r.httpItem.method = 'POST';
    r.httpItem.fullUrl = url;
    r.bodyJson = {};
    r.bodyJson!['request'] = 'get_green_syncs';

    r.httpRequestEvents.onAnyState = (res) async {
      if(res.isOk){
        Map r = res.getBodyAsJson()!;

        for(final k in r[Keys.data]){
          greenSyncList.add(SyncModel.fromMap(k));
        }

        setState(() {});
      }

      return null;
    };

    r.request();
  }

  void requestSensors() {
    final r = Requester();
    r.httpItem.method = 'POST';
    r.httpItem.fullUrl = url;
    r.bodyJson = {};
    r.bodyJson!['request'] = 'get_sensors';

    r.httpRequestEvents.onAnyState = (res) async {
      if(res.isOk){
        Map r = res.getBodyAsJson()!;

        for(final k in r[Keys.data]){
          sensorList.add(SensorModel.fromMap(k));
        }

        setState(() {});
      }

      return null;
    };

    r.request();
  }

  void requestSensorData(int sensorId) {
    final r = Requester();
    r.httpItem.method = 'POST';
    r.httpItem.fullUrl = url;
    r.bodyJson = {};
    r.bodyJson!['request'] = 'get_sensor_data';
    r.bodyJson!['sensor_id'] = sensorId;

    r.httpRequestEvents.onAnyState = (res) async {
      if(res.isOk){
        Map r = res.getBodyAsJson()!;

        for(final k in r[Keys.data]){
          currentSensorDataList.add(SensorDataModel.fromMap(k));
        }

        setState(() {});
      }

      return null;
    };

    r.request();
  }
}
