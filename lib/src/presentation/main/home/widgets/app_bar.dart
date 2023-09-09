import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mouvema/src/core/utils/image_manager.dart';

import '../../../shared/choose_location_button.dart';
import '../../../shared/select_truck_type.dart';
import '../../filter/filter_screen.dart';

class AppBarz extends StatelessWidget {
  const AppBarz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      leading: null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            ImageManager.logo,
            height: 40,
            width: 40,
          ),
          const Text('Mouvema'),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      String? origin, destination, type;
                      return FilterScreen(
                        onOriginSelected: (val) {
                          origin = val;
                        },
                        onDestinationSelected: (val) {
                          destination = val;
                        },
                        onTruckSelected: (val) {
                          type = val;
                        },
                      );
                    });
              },
              icon: const Icon(Icons.filter_alt_outlined, size: 30)),
        ],
      ),
      floating: true,
      elevation: 4,
    );
  }
}
