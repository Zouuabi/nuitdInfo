import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/data/repository/repository_impl.dart';
import 'package:mouvema/src/injector.dart';
import 'package:mouvema/src/presentation/blog/cubit/blog_cubit.dart';
import 'package:mouvema/src/presentation/blog/cubit/blog_state.dart';
import 'package:mouvema/src/presentation/blog/widgets/article.dart';

import '../../../core/utils/string_manager.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedCubit(instance<RepositoryImpl>()),
      child: BlocConsumer<FeedCubit, FeedState>(listener: (context, state) {
        if (state.status == Status.fetchFailed) {
          AwesomeDialog(
            btnOkColor: Colors.teal,
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: StringManager.error,
          ).show();
        }
      }, builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == Status.fetchSuccess) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ...state.data!
                      .map((e) => ArticleItem(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/articleDetails', arguments: e);
                            },
                            imageUrl: e.imageUrl,
                            likesNum: e.likesNum,
                            lovesNum: e.lovesNum,
                            title: e.title,
                          ))
                      .toList()
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text(state.errorMessage ?? 'Something went Wrong'),
          );
        }
      }),
    );
  }
}
