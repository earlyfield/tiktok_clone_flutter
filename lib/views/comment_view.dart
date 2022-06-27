import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_flutter/models/comment/comment.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/view_models/comment_view_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentView extends ConsumerWidget {
  final CommentViewModel viewModel;
  final String id;
  CommentView(
    this.viewModel, {
    Key? key,
    required this.id,
  }) : super(key: key);

  final TextEditingController _commentController = TextEditingController();

  Widget commentItem(WidgetRef ref, Comment comment) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        backgroundImage: NetworkImage(comment.profilePhoto),
      ),
      title: Row(
        children: [
          Text(
            "${comment.username}  ",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            comment.comment,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
      subtitle: Row(
        children: [
          Text(
            timeago.format(
              comment.datePublished.toLocal(),
            ),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${comment.likes.length} likes',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
      trailing: InkWell(
        onTap: () => viewModel.likeComment(id, comment.id),
        child: Icon(
          Icons.favorite,
          size: 25,
          color: comment.likes.contains(ref.watch(userProvider).uid)
              ? Colors.red
              : Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final comments = ref.watch(commentsStreamProvider(id));

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: comments.when(
                  data: (comments) {
                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return commentItem(ref, comment);
                      },
                    );
                  },
                  error: (err, stack) => Center(
                    child: Text(err.toString()),
                  ),
                  loading: () => const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () =>
                      viewModel.postComment(id, _commentController.text),
                  child: const Text(
                    "Send",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
