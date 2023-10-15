import 'package:app/managers/settings_manager.dart';
import 'package:app/structures/middleWares/requester.dart';
import 'package:app/system/extensions.dart';
import 'package:app/system/keys.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_http.dart';
import 'package:app/tools/app/app_icons.dart';
import 'package:flutter/material.dart';


import 'package:app/structures/abstract/state_super.dart';

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
  List<Map> greenMind = [];


  @override
  void initState(){
    super.initState();
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
          const Divider(),
          const SizedBox(height: 12),

          buildRegisterGreenMind(),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),


          buildRegisterGreenMin(),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sample:  ').bold(),
            const Expanded(
                child: SelectableText('{"request": "register_green_mind", "serial_number": "abcdef", "product_date": "2023-10-11"}')
            ),
          ],
        ),

        const SizedBox(height: 5),
        Row(
          children: [
            const Text('required fields: ').bold(),
            const Text('serial_number'),
          ],
        ),
        const Text('response: {"status":"ok", "id" : "mind id"}'),

        IconButton(
            onPressed: onRefreshGreenMind,
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

  Widget buildRegisterGreenMin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Registering Green Mind').bold().color(AppDecoration.mainColor),
        const SizedBox(height: 20),
        SelectableText('URL: $url'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sample:  ').bold(),
            const Expanded(
                child: SelectableText('{"request": "register_green_mind", "serial": "abcdef", "product_date": "2023-10-11"}')
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Text('required fields: ').bold(),
            const Text('serial'),
          ],
        ),
        const Text('response: {"id" : "mind id"}'),

        IconButton(
            onPressed: onRefreshGreenMind,
            icon: const Icon(AppIcons.refresh)
        ),

        DataTable(
          border: TableBorder.all(color: Colors.black54, width: 1),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('SN')),
              DataColumn(label: Text('firmware')),
              DataColumn(label: Text('register_date')),
              DataColumn(label: Text('product_date')),
              DataColumn(label: Text('active_date')),
            ],
            rows: [
              ...generateGreenMindRows(),
            ],
        )
      ],
    );
  }

  List generateGreenMindRows(){
    return [
      const DataRow(cells: [
        DataCell(Text('100'),) ,
        DataCell(Text('sdfghjkl')),
        DataCell(Text('123456789123456789')),
        DataCell(Text('2023/20/20')),
        DataCell(Text('2023/20/20')),
        DataCell(Text('2023/20/20')),
      ]),
    ];
  }
  void onRefreshGreenMind() {
    final ht = HttpItem();

    final r = Requester();
    r.httpItem.method = 'POST';
    r.httpItem.fullUrl = url;
    r.bodyJson = {};
    r.bodyJson!['request'] = 'get_green_minds';

    r.httpRequestEvents.onAnyState = (res) async {
      if(res.isOk){
        Map r = res.getBodyAsJson()!;
        greenMind = r[Keys.date];
        print('yyyyyyyyyy');
        print(greenMind);
      }

      return null;
    };

    r.request();
  }
}
