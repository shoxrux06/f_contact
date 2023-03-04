import 'package:f_contact/pages/contact/add_contact_page.dart';
import 'package:f_contact/pages/home/riverpod/provider/home_provider.dart';
import 'package:f_contact/pages/home/widget/custom_bottom_dialog.dart';
import 'package:f_contact/pages/home/widget/custom_radio_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

import '../../data/data.dart';
import '../contact/riverpod/provider/contact_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late TextEditingController controller;

  loadData() async {
    final notifier = ref.watch(contactProvider.notifier);
    await notifier.loadContacts();
  }

  loadAddress() {
    final homeNotifier = ref.watch(homeProvider.notifier);
    homeNotifier.getRegionList();
  }
  @override
  void initState() {
    print('****************INIT STATE HOME CONTACT ****************');
    Future.delayed(Duration.zero, () {
      loadData();
      loadAddress();
    });
    controller = TextEditingController();
    super.initState();
  }

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
    final notifier = ref.watch(contactProvider.notifier);
    final state = ref.watch(contactProvider);
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return const AddContactPage(
                        contactModel: null,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: state.isLoadingTable
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (state.contactList.isEmpty && state.isSearchingFromTable)
              ? const Center(
                  child: Text('You do not have any contact'),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 4, bottom: 8, left: 8, right: 8),
                              height: 56,
                              child: TextFormField(
                                onChanged: (String value) {
                                  notifier.searchItemByName(value);
                                },
                                style: const TextStyle(fontSize: 14),
                                controller: controller,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  alignLabelWithHint: false,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Colors.black54,
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Colors.black87,
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  labelText: 'Search contact',
                                  labelStyle: const TextStyle(fontSize: 14),
                                  hintStyle: const TextStyle(fontSize: 14),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      notifier.searchItemByName(controller.text);
                                    },
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(24),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text('Filter', style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black
                                            ),),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            const Text('Region',style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black
                                            )),
                                            IntrinsicWidth(
                                              child: RadioGroup(
                                                key: verticalGroupKey,
                                                controller: verticalGroupController,
                                                values: homeState.regionList,
                                                onChanged: (newValue) => setState(() {
                                                  verticalValAutomatic = newValue.toString();
                                                }),
                                                decoration: const RadioGroupDecoration(
                                                  labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                radioGroupController = verticalGroupController;
                                                notifier.filterByRegion(radioGroupController.value.toString()).then((value) {
                                                  if(state.contactList.isEmpty){

                                                  }
                                                });
                                                setState(() {
                                                  verticalValRequested = radioGroupController.value.toString();
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "Apply",
                                                style: TextStyle(fontSize: 21),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(Icons.filter_list),
                          ),
                        ],
                      ),
                      state.contactList.isEmpty? Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 24,),
                              Text('Not found'),
                              SizedBox(height: 24,),
                              ElevatedButton(onPressed: (){
                                loadData();
                              }, child: Icon(Icons.refresh)),
                            ],
                          ),
                        ),
                      ):Expanded(
                        child: ListView.builder(
                          itemCount: state.contactList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.contactList[index].fullName),
                              subtitle:
                                  Text(state.contactList[index].phoneNumber),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      notifier.deleteContacts(state.contactList[index].id);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print('Contact id => ${state.contactList[index].id}');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return AddContactPage(
                                              contactModel:
                                                  state.contactList[index],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
