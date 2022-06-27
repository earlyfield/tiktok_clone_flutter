import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_flutter/models/profile_user/profile_user.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/view_models/profile_view_model.dart';
import 'package:tiktok_clone_flutter/view_models/signin_view_model.dart';

class ProfileView extends ConsumerStatefulWidget {
  final ProfileViewModel viewModel;
  const ProfileView(
    this.viewModel, {
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late ProfileViewModel _viewModel;
  final SigninViewModel _signinViewModel = SigninViewModel("");

  @override
  void initState() {
    super.initState();

    _signinViewModel.setRef(ref);

    _viewModel = widget.viewModel;
    _viewModel.setRef(ref);

    _viewModel.getUserData();
  }

  @override
  void dispose() {
    // ref.watch(profileUserProvider.notifier).update((state) => ProfileUser(
    //     name: "",
    //     profilePhoto: "",
    //     thumbnails: [],
    //     likes: "",
    //     followers: "",
    //     following: "",
    //     isFollowing: false));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _viewModel.getUserData();

    var uid = ref.watch(profileUserUidProvider);
    var profileUser = ref.watch(profileUserProvider);
    var authUser = ref.watch(userProvider);

    print("Profile photo URL: ${profileUser.profilePhoto}");

    return profileUser.name == ""
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              leading: const Icon(
                Icons.person_add_alt_1_outlined,
              ),
              actions: const [
                Icon(Icons.more_horiz),
              ],
              title: Text(
                profileUser.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: profileUser.profilePhoto,
                            height: 100,
                            width: 100,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              profileUser.following,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Following',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black54,
                          width: 1,
                          height: 15,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              profileUser.followers,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Followers',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black54,
                          width: 1,
                          height: 15,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              profileUser.likes,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Likes',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 140,
                      height: 47,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            if (uid == authUser.uid) {
                              _signinViewModel.signout();
                            } else {
                              _viewModel.followUser();
                            }
                          },
                          child: Text(
                            uid == authUser.uid
                                ? 'Sign Out'
                                : profileUser.isFollowing
                                    ? 'Unfollow'
                                    : 'Follow',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileUser.thumbnails.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        String thumbnail = profileUser.thumbnails[index];
                        return CachedNetworkImage(
                          imageUrl: thumbnail,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
