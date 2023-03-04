import 'package:f_contact/data/address_data_class.dart';
import 'package:f_contact/data/data.dart';
import 'package:f_contact/pages/home/riverpod/state/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends StateNotifier<HomeState>{
  HomeNotifier(): super(const HomeState());

  getRegionList() async {
    final addressData = AddressDataClass.fromJson(myData);
    state = state.copyWith(regionList: []);
    final regionList = addressData.region.map((e) => e.name).toList();
    final region = addressData.region.toList();
    print('regionList << $regionList >>');
    print('regionList << ${addressData.region} >>');
    state = state.copyWith(region:region,regionList: regionList);
  }

  getCode(String name) {
    print('name --> $name');
    for(int i = 0;i<state.regionList.length;i++){
      if(name == state.region[i].name){
        print('code --> ${state.region[i].code}');
        state = state.copyWith(code: state.region[i].code);
      }
    }
  }

  getDistrictList(String code){
    print('code in getDistrictList  ---> $code');
    final addressData = AddressDataClass.fromJson(myData);
    state = state.copyWith(districtList: []);
    final List<String> sortedDistrictList = [];
    for(int i = 0;i< addressData.district.length;i++){
      if(addressData.district[i].region == code){
        sortedDistrictList.add(addressData.district[i].name);
      }
    }
    print('sortedDistrict << $sortedDistrictList >>');
    state = state.copyWith(districtList: sortedDistrictList);
  }
}