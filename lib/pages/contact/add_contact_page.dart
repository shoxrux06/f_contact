import 'package:f_contact/data/contact_model.dart';
import 'package:f_contact/pages/contact/riverpod/provider/contact_provider.dart';
import 'package:f_contact/pages/contact/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data.dart';

class AddContactPage extends ConsumerStatefulWidget {
  const AddContactPage({Key? key, required this.contactModel})
      : super(key: key);

  final ContactModel? contactModel;

  @override
  ConsumerState<AddContactPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<AddContactPage> {
  late TextEditingController fullNameController;
  late TextEditingController phoneNUmberController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  final List<Map<String, dynamic>>? country = myData['COUNTRY'];
  final List<Map<String, dynamic>>? region = myData['REGION'];
  final List<Map<String, dynamic>>? district = myData['DISTRICT'];

  String? selectedCountryName;
  String? selectedRegionName;
  String? selectedDistrictName;

  String? selectedCountryCondition;
  String? selectedRegionCode;

  List<Map<String, dynamic>>? sortedRegionList = [];
  List<Map<String, dynamic>>? sortedDistrictList = [];

  late Map<String, List<Map<String, dynamic>>>? dataset = {
    'COUNTRY': country!,
    'REGION': region!,
    'DISTRICT': district!,
  };

  setCountry() {
    if (widget.contactModel != null) {
      setState(() {
        selectedCountryName = widget.contactModel?.country;
        selectedRegionName = widget.contactModel?.region;
        selectedDistrictName = widget.contactModel?.district;
      });
    }
  }

  bool get validator {
    if (fullNameController.text.isEmpty ||
        phoneNUmberController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        selectedCountryName == null ||
        selectedRegionName == null ||
        selectedDistrictName == null){
      return false;
    }else{
      return true;
    }
  }

  setList() {
    if (selectedCountryName != selectedCountryName) selectedRegionName = null;
    if (selectedRegionName != selectedRegionName) selectedDistrictName = null;
    setState(() {
      selectedCountryCondition = dataset?['COUNTRY']?[0]['condition'];
      sortedRegionList = dataset?['REGION']
          ?.where((element) => element['condition'] == selectedCountryCondition)
          .toList();
      setState(() {
        var l = dataset?['REGION']!.length.toInt() ?? 0;
        for (int i = 0; i < l; i++) {
          if (dataset?['REGION']?[i]['name'] == selectedRegionName) {
            selectedRegionCode = dataset?['REGION']?[i]['code'];
          }
        }
        sortedDistrictList = dataset?['DISTRICT']
            ?.where((element) => element['region'] == selectedRegionCode)
            .toList();
      });
      print('setList --> $selectedRegionCode');
      print('Selected Rayon $selectedDistrictName');
      print('setList --> $sortedDistrictList');
      print('setList length --> ${sortedDistrictList?.length}');
    });
  }

  @override
  void initState() {
    fullNameController = TextEditingController(text: widget.contactModel?.fullName);
    phoneNUmberController = TextEditingController(text: widget.contactModel?.phoneNumber);
    emailController = TextEditingController(text: widget.contactModel?.email);
    addressController = TextEditingController(text: widget.contactModel?.address);

    print('****************INIT STATE ADD CONTACT ****************');
    setCountry();
    Future.delayed(Duration.zero, () {
      final state = ref.watch(contactProvider);
      print('Contact list <<${state.contactList}>>');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('**************** BUILD ADD CONTACT ****************');
    if (widget.contactModel != null) {
      setList();
    }
    final state = ref.watch(contactProvider);
    final notifier = ref.watch(contactProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.contactModel != null ? 'Edit Contact' : 'Add contact'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                controller: fullNameController,
                label: 'ФИО',
              ),
              CustomTextField(
                controller: phoneNUmberController,
                label: 'Номер телефона',
              ),
              CustomTextField(
                controller: emailController,
                label: 'Email адрес',
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField<String?>(
                    decoration: decoration('Страна'),
                    value: selectedCountryName,
                    elevation: 0,
                    isDense: true,
                    isExpanded: false,
                    items: dataset?['COUNTRY']?.map((e) {
                      return DropdownMenuItem<String?>(
                        value: e['name'],
                        child: Text(
                          '${e['name'].toString().toUpperCase()}',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 8),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != selectedCountryName)
                        selectedRegionName = null;
                      setState(() {
                        var l = dataset?['COUNTRY']!.length.toInt() ?? 0;
                        for (int i = 0; i < l; i++) {
                          if (dataset?['COUNTRY']?[i]['name'] == value) {
                            selectedCountryCondition =
                                dataset?['COUNTRY']?[i]['condition'];
                          }
                        }
                        selectedCountryName = value!;
                        sortedRegionList = dataset?['REGION']
                            ?.where((element) =>
                                element['condition'] ==
                                selectedCountryCondition)
                            .toList();
                      });
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField<String?>(
                    decoration: decoration('Регион'),
                    value: selectedRegionName,
                    elevation: 0,
                    key: (selectedRegionName != null)
                        ? Key(selectedRegionName ?? '')
                        : UniqueKey(),
                    items: (sortedRegionList)?.map((e) {
                      return DropdownMenuItem<String?>(
                        value: e['name'],
                        child: Text(
                          '${e['name']}',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 8),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != selectedRegionName)
                        selectedDistrictName = null;
                      setState(() {
                        var l = dataset?['REGION']!.length.toInt() ?? 0;
                        for (int i = 0; i < l; i++) {
                          if (dataset?['REGION']?[i]['name'] == value) {
                            selectedRegionCode = dataset?['REGION']?[i]['code'];
                          }
                        }
                        selectedRegionName = value!;
                        sortedDistrictList = dataset?['DISTRICT']
                            ?.where((element) =>
                                element['region'] == selectedRegionCode)
                            .toList();
                      });
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField<String?>(
                    decoration: decoration('Район'),
                    value: (selectedDistrictName?.isNotEmpty ?? false)
                        ? selectedDistrictName
                        : null,
                    items: (sortedDistrictList ?? []).map((e) {
                      return DropdownMenuItem<String?>(
                        value: e['name'],
                        child: Text(
                          '${e['name']}',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 8),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedDistrictName = val!;
                      });
                    }),
              ),
              const SizedBox(
                height: 4,
              ),
              CustomTextField(
                controller: addressController,
                label: 'Адресс проживания',
              ),
              const SizedBox(height: 44),
              InkWell(
                onTap: () async {
                  if(validator){
                    if (widget.contactModel != null) {
                      await notifier
                          .updateContacts(
                        widget.contactModel?.id ?? 0,
                        fullNameController.text.trim(),
                        phoneNUmberController.text.trim(),
                        emailController.text.trim(),
                        selectedCountryName,
                        selectedRegionName,
                        selectedDistrictName,
                        addressController.text.trim(),
                      )
                          .then((value) => Navigator.of(context).pop());
                    } else {
                      await notifier.createContacts(
                        fullNameController.text.trim(),
                        phoneNUmberController.text.trim(),
                        emailController.text.trim(),
                        selectedCountryName,
                        selectedRegionName,
                        selectedDistrictName,
                        addressController.text.trim(),
                      )
                          .then((value) => Navigator.of(context).pop());
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill all fields!"),
                    ));
                  }

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black87,
                  height: 48,
                  child: Center(
                    child: (state.isAddingToTable || state.isUpdatingToTable)
                        ? const CircularProgressIndicator()
                        : Text(
                            widget.contactModel != null
                                ? 'Edit Contact'
                                : 'Add Contact',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration decoration(String label) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(10.0),
      alignLabelWithHint: false,
      floatingLabelBehavior: FloatingLabelBehavior.always,
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
      labelText: label,
      labelStyle: const TextStyle(fontSize: 14),
      hintStyle: const TextStyle(fontSize: 14),
    );
  }
}
