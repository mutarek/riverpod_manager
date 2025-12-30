import 'package:manager/feature/home/data/user_model.dart';

abstract class IUserRepository {
  Future<List<UserModelResponse>> getUsers();
  // Future<UserModelResponse> getUserById(int id);
  // Future<UserModelResponse> createUser(User user);
  // Future<UserModelResponse> updateUser(int id, User user);
  Future<void> deleteUser(int id);
}