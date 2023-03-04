import 'package:f_contact/pages/home/riverpod/notifier/home_notifier.dart';
import 'package:f_contact/pages/home/riverpod/state/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) => HomeNotifier());