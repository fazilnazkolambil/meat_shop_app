import 'package:flutter_riverpod/flutter_riverpod.dart';

final quantityProvider = StateProvider<int>((ref) => 1);
final carouselaProvider = StateProvider<int?>((ref) => 0);
final loadingProvider = StateProvider<bool?>((ref) => null);