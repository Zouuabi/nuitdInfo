import 'package:dartz/dartz.dart' as dartz;
import 'package:doft/src/core/failure.dart';
import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:doft/src/injector.dart';
import 'package:flutter/material.dart';
import '../../../data/models/load.dart';

import '../../../data/models/user.dart';
import 'widgets/details.dart';
import '../../shared/map_view.dart';

class LoadDetailsScreen extends StatelessWidget {
  const LoadDetailsScreen({super.key, required this.load});

  final Load load;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(
          Icons.call,
          color: Colors.white,
        ),
      ),
      //appBar: _getAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // *** kharita
              MapView(size: size),
              const SizedBox(height: 20),

              ToggleFavorites(loadRef: load.loadRef),
              const SizedBox(height: 20),

              Details(
                load: load,
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ToggleFavorites(
            loadRef: load.loadRef,
          )
        ],
      ),
      centerTitle: true,
    );
  }
}

class ToggleFavorites extends StatefulWidget {
  const ToggleFavorites({super.key, required this.loadRef});

  final String loadRef;

  @override
  State<ToggleFavorites> createState() => _ToggoleFavoritesState();
}

class _ToggoleFavoritesState extends State<ToggleFavorites> {
  bool isAdded = false;
  late List<dynamic> favoriteLoads;

  void test() async {
    dartz.Either<Failure, MyUser> result =
        await repositoryImpl.getCurrentUserInformation();

    result.fold(
      (l) {
        isAdded = false;
      },
      (user) {
        favoriteLoads = user.favoriteLoads;
        if (favoriteLoads.contains(widget.loadRef)) {
          isAdded = true;
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    test();
  }

  final repositoryImpl = instance<RepositoryImpl>();
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          if (isAdded == true) {
            repositoryImpl.removeLoadFromFavorites(widget.loadRef);
            setState(() {
              isAdded = false;
            });
          } else {
            repositoryImpl.addLoadToFavorites(widget.loadRef);
            setState(() {
              isAdded = true;
            });
          }
        },
        icon: isAdded
            ? const Icon(Icons.bookmark)
            : const Icon(Icons.bookmark_add_outlined));
  }
}
