import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/feature/home/data/user_model.dart';
import 'package:manager/feature/home/data_source/user_remote_data_source.dart';
import 'package:manager/feature/home/reposiotories/user_repository_interface.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  return UserRepository(remoteDataSource);
});

class UserRepository implements IUserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepository(this._remoteDataSource);

  @override
  Future<void> deleteUser(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserModelResponse>> getUsers() async {
    try {
      final userModels = await _remoteDataSource.getUsers();
      return userModels.map((model) => model.toDomain()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
