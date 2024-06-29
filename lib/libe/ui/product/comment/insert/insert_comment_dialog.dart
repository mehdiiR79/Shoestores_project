import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoestores/libe/data/repo/comment_repository.dart';
import 'package:shoestores/libe/ui/product/comment/insert/insert_comment_bloc.dart';


class InsertCommentDialog extends StatefulWidget {
  final int productId;
  final ScaffoldMessengerState? scaffoldMessager;

  const InsertCommentDialog(
      {Key? key, required this.productId, this.scaffoldMessager})
      : super(key: key);

  @override
  State<InsertCommentDialog> createState() => _InsertCommentDialogState();
}

class _InsertCommentDialogState extends State<InsertCommentDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  StreamSubscription? subscription;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = InsertCommentBloc(commentRepository, widget.productId);
        subscription = bloc.stream.listen((state) {
          if (state is InsertCommentSuccess) {
            widget.scaffoldMessager?.showSnackBar(
                SnackBar(content: Text(state.message)));
            Navigator.of(context, rootNavigator: true).pop();
          } else if (state is InsertCommentError) {
            widget.scaffoldMessager?.showSnackBar(
                SnackBar(content: Text(state.appException.message)));
            Navigator.of(context, rootNavigator: true).pop();
          }
        });
        return bloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 300,
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<InsertCommentBloc, InsertCommentState>(
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    'ثبت نظر',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(label: Text('عنوان')),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                        label: Text('متن نظر خود را اینجا وارد کنید')),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<InsertCommentBloc>().add(
                          InsertCommentFormSubmit(
                              _titleController.text, _contentController.text));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is InsertCommentLoading)
                          CupertinoActivityIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        const Text('ذخیره'),
                      ],
                    ),
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(Size.fromHeight(56))),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
