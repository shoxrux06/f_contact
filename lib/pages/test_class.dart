import 'package:f_contact/data/data.dart';
import 'package:flutter/material.dart';

class MultiLevelDropDownExample extends StatefulWidget {
  const MultiLevelDropDownExample({Key? key}) : super(key: key);

  @override
  State<MultiLevelDropDownExample> createState() =>
      _MultiLevelDropDownExampleState();
}

class _MultiLevelDropDownExampleState extends State<MultiLevelDropDownExample> {
  final List<Map<String, dynamic>>? region = myData['REGION'];
  final List<Map<String, dynamic>>? district = myData['DISTRICT'];
  List<Map<String, dynamic>>? sortedDistrict = [];

  String? selectedRegionName;
  String? selectedRegionCode;
  String? selectedDistrictName;

  late Map<String, List<Map<String, dynamic>>>? dataset = {
    'REGION': region!,
    'DISTRICT': district!,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String?>(
                value: selectedRegionName,
                underline: null,
                elevation: 0,
                items: dataset?['REGION']?.map((e) {
                  return DropdownMenuItem<String?>(
                    value: e['name'],
                    child: Text(
                      '${e['name']}',
                      style: TextStyle(color: Colors.black87, fontSize: 8),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  print('Region <<$value>>');
                  if(value != selectedRegionName) selectedDistrictName = null;
                  setState(() {
                    var l = dataset?['REGION']!.length.toInt()??0;
                    for(int i = 0;i<l;i++){
                      if(dataset?['REGION']?[i]['name'] == value){
                        selectedRegionCode = dataset?['REGION']?[i]['code'];
                      }
                    }
                    selectedRegionName = value!;
                    sortedDistrict = dataset?['DISTRICT']?.where((element) => element['region'] == selectedRegionCode).toList();
                    print('selectedRegionCode <<$selectedRegionCode>>');
                    print('sortedDistrict <<$sortedDistrict>>');
                  });
                }),
            const SizedBox(
              height: 10,
            ),
            DropdownButton<String?>(
                value: selectedDistrictName,
                items: (sortedDistrict ?? []).map((e) {
                  return DropdownMenuItem<String?>(
                    value: e['name'],
                    child: Text(
                      '${e['name']}',
                      style: TextStyle(color: Colors.black87, fontSize: 8),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  print('District <<$val>>');
                  setState(() {
                    selectedDistrictName = val!;
                  });
                }),
            //
          ],
        ),
      ),
    );
  }
}
