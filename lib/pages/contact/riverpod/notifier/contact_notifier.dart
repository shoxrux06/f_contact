import 'package:f_contact/data/data.dart';
import 'package:f_contact/helper/sql_helper.dart';
import 'package:f_contact/pages/contact/riverpod/state/contact_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactNotifier extends StateNotifier<ContactState> {
  ContactNotifier() : super(const ContactState());

  Future<void> createContacts(
    String fullName,
    String? phoneNumber,
    String? email,
    String? country,
    String? region,
    String? district,
    String? address,
  ) async {
    final sqlHelper = SQLHelper();
    state = state.copyWith(isAddingToTable: true);
    final number = await sqlHelper.createItem(
        fullName, phoneNumber, email, country, region, district, address);
    print('number => $number');
    final contactList = await sqlHelper.getItems();
    state = state.copyWith(contactList: contactList, isAddingToTable: false);
  }

  Future<void> loadContacts() async {
    final sqlHelper = SQLHelper();
    state = state.copyWith(contactList: [], isLoadingTable: true);
    final contactList = await sqlHelper.getItems();
    state = state.copyWith(contactList: contactList, isLoadingTable: false);
  }

  Future<void> searchItemByName(String query) async {
    final sqlHelper = SQLHelper();
    if(query.isNotEmpty){
      state = state.copyWith(isSearchingFromTable: true);
    }else{
      state = state.copyWith(isSearchingFromTable: false);
    }
    state = state.copyWith(contactList: []);
    var contactList = await sqlHelper.getItems();
    contactList = contactList.where((element) => element.fullName.toUpperCase().contains(query.toUpperCase())).toList();
    state = state.copyWith(contactList: contactList, isSearchingFromTable: false);
  }

  Future<void> filterByRegion(String item) async {
    final sqlHelper = SQLHelper();
    if(item.isNotEmpty){
      state = state.copyWith(isFilteringByRegion: true);
    }else{
      state = state.copyWith(isFilteringByRegion: false);
    }
    state = state.copyWith(contactList: []);
    var contactList = await sqlHelper.getItems();
    contactList = contactList.where((element) => element.region == item).toList();
    state = state.copyWith(contactList: contactList, isFilteringByRegion: false);
  }

  deleteContacts(int id) async {
    final sqlHelper = SQLHelper();
    state = state.copyWith(isDeletingFromTable: true);
    await sqlHelper.deleteItem(id);
    final contactList = await sqlHelper.getItems();
    state = state.copyWith(contactList: contactList, isDeletingFromTable: false);
  }

  Future<void> updateContacts(
    int id,
    String fullName,
    String? phoneNumber,
    String? email,
    String? country,
    String? region,
    String? district,
    String? address,
  ) async {
    final sqlHelper = SQLHelper();
    state = state.copyWith(isUpdatingToTable: true);
    final number = await sqlHelper.updateItem(
        id, fullName, phoneNumber, email, country, region, district, address);
    print('number updated => $number');
    final contactList = await sqlHelper.getItems();
    state = state.copyWith(contactList: contactList, isUpdatingToTable: false);
  }
}
