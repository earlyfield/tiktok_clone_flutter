import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/providers/routerProvider.dart';

class SearchView extends ConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: TextFormField(
          decoration: const InputDecoration(
            filled: false,
            hintText: 'Search',
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          onFieldSubmitted: (value) =>
              ref.watch(typedUserProvider.notifier).update((state) => value),
        ),
      ),
      body: ref.watch(searchedUsersStreamProvider).when(
            data: (users) {
              print("Users: $users");
              return users.isEmpty
                  ? const Center(
                      child: Text(
                        "Search for users!",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return InkWell(
                          onTap: () {
                            ref
                                .watch(profileUserUidProvider.notifier)
                                .update((state) => user.uid);
                            ref.watch(routerProvider).go('/profile');
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                user.profilePhoto,
                              ),
                            ),
                            title: Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
            error: (err, stack) => Center(
              child: Text(
                err.toString(),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
