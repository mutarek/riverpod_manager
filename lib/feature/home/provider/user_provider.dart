import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/feature/home/data/user_model.dart';

import '../reposiotories/user_repository.dart';

final userListProvider = FutureProvider<List<UserModelResponse>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getUsers();
});

final usersAsyncProvider =
    AsyncNotifierProvider<UserNotifier, List<UserModelResponse>>(UserNotifier.new);

class UserNotifier extends AsyncNotifier<List<UserModelResponse>> {
  @override
  FutureOr<List<UserModelResponse>> build() async {
    final repository = ref.watch(userRepositoryProvider);
    return await repository.getUsers();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(userRepositoryProvider);
      return await repository.getUsers();
    });
  }
}
