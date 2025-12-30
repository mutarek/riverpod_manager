import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/feature/home/provider/user_provider.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(usersAsyncProvider);
    return Scaffold(
      body: userAsync.when(
        data: (data) {
          if(data.isEmpty){
            return Center(child: Text("No Data Found"));
          }
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(usersAsyncProvider.notifier).refresh();
            },
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (_,index){
                return ListTile(
                  title: Text(data[index].name.toString()));
              },
            ),
          );
        },
        error: (error, stacktrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
