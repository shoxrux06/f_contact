import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

import '../../../data/data.dart';

class CustomBottomDialog extends StatefulWidget {
  const CustomBottomDialog({Key? key, required this.setState}) : super(key: key);

  final StateSetter setState;

  @override
  State<CustomBottomDialog> createState() => _CustomBottomDialogState();
}

class _CustomBottomDialogState extends State<CustomBottomDialog> {
  String verticalValAutomatic = "";
  String verticalValAutomatic2 = "";

  /// The currently selected value of the vertical radio group.
  ///
  /// This one is obtained by clicking the "Fetch Selected" button under the
  /// vertical radio group.
  String verticalValRequested = "";
  String verticalValRequested2 = "";

  /// The key for the vertical radio group.
  final GlobalKey<RadioGroupState> verticalGroupKey = GlobalKey<RadioGroupState>();
  final GlobalKey<RadioGroupState> verticalGroupKey2 = GlobalKey<RadioGroupState>();

  /// The controller for the vertical radio group.
  final RadioGroupController verticalGroupController = RadioGroupController();
  final RadioGroupController verticalGroupController2 = RadioGroupController();

  late RadioGroupController radioGroupController;

  @override
  Widget build(BuildContext context) {
    List<String> titles = [];
    List<String> titles2 = [];
    List<String> sortedTiles2 = [];

    String selectedRegionCode = '';

    int l = myData['REGION']?.length??0;
    int l2 = myData['DISTRICT']?.length??0;

    for(int i = 0;i<l;i++){
      titles.add(myData['REGION']![i]['name'].toString());
    }

    for(int i = 0;i<l2;i++){
      titles2.add(myData['DISTRICT']![i]['name'].toString());
    }

    return Container(
      padding: EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Filter'),
            const SizedBox(
              height: 24,
            ),
            Text('Region'),
            IntrinsicWidth(
              child: RadioGroup(
                key: verticalGroupKey,
                controller: verticalGroupController,
                values: titles,
                onChanged: (newValue) => widget.setState(() {
                  verticalValAutomatic = newValue.toString();
                }),
                decoration: const RadioGroupDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                radioGroupController = verticalGroupController;
                int len = myData['REGION']?.length??0;

                widget.setState(() {
                  verticalValRequested = radioGroupController.value.toString();
                  for(int i = 0;i<len;i++) {
                    if(myData['REGION']![i]['name'] == verticalValRequested){
                      selectedRegionCode = myData['REGION']![i]['code'].toString();
                    }
                  }
                  final list = myData['DISTRICT']?.where((element) {
                    return element['region'] == selectedRegionCode;
                  }).toList();
                  print('DISTRICT -->> $list');
                  int l = list?.length??0;
                  for(int i = 0;i<l;i++){
                    sortedTiles2.add(myData['DISTRICT']![i]['name'].toString());
                  }
                  print('Selected region --> $verticalValRequested');
                  print('Selected distrit list --> $sortedTiles2');
                });
              },
              child: const Text(
                "Fetch Selected",
                style: TextStyle(fontSize: 21),
              ),
            ),

            // '***********************************'

            sortedTiles2.isNotEmpty?Text('District'):Container(),
            sortedTiles2.isNotEmpty?IntrinsicWidth(
              child: RadioGroup(
                key: verticalGroupKey2,
                controller: verticalGroupController2,
                values: sortedTiles2,
                onChanged: (newValue) => widget.setState(() {
                  verticalValAutomatic2 = newValue.toString();
                }),
                decoration: const RadioGroupDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ): Container(),
            sortedTiles2.isNotEmpty?TextButton(
              onPressed: () {
                radioGroupController = verticalGroupController2;
                widget.setState(() {
                  verticalValRequested2 = radioGroupController.value.toString();
                  print('Selected region --> $verticalValRequested');
                });
              },
              child: const Text(
                "Fetch Selected",
                style: TextStyle(fontSize: 21),
              ),
            ): Container(),
          ],
        ),
      ),
    );
  }
}
