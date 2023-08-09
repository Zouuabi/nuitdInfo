import 'package:doft/src/data/repository/repository_impl.dart';
import 'package:flutter/material.dart';

import '../../../data/models/load.dart';
import '../../../injector.dart';
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
      appBar: _getAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // *** kharita
              MapView(size: size),
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
            onclicked: (isadd) {
              if (isadd == false) {
                //load mawjouda w bech enna77ouha
              } else {
                //
              }
            },
          )
        ],
      ),
      centerTitle: true,
    );
  }
}

class ToggleFavorites extends StatefulWidget {
  const ToggleFavorites({super.key, required this.onclicked});
  final void Function(bool isadd) onclicked;

  @override
  State<ToggleFavorites> createState() => _ToggoleFavoritesState();


  // sdfsdf sdf 
}

class _ToggoleFavoritesState extends State<ToggleFavorites> {

  final g = instance<RepositoryImpl>(); 
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            isAdded = !isAdded;
            g.addLoadToFavorites(loadRef); 
          });
          widget.onclicked(isAdded);
        },
        icon: isAdded
            ? const Icon(Icons.bookmark)
            : const Icon(Icons.bookmark_add_outlined));
  }
}
