import 'package:f_contact/pages/contact/riverpod/notifier/contact_notifier.dart';
import 'package:f_contact/pages/contact/riverpod/state/contact_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactProvider = StateNotifierProvider<ContactNotifier, ContactState>((ref) => ContactNotifier());