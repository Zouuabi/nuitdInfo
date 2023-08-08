import 'package:doft/src/presentation/main/post_load/cubits/post_load_cubit.dart';
import 'package:doft/src/presentation/main/post_load/cubits/post_load_state.dart';
import 'package:doft/src/presentation/shared/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/helpers/date_picker.dart';
import '../../shared/map_view.dart';

class PostLoadScreen extends StatelessWidget {
  const PostLoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedType = 'Any';
    Size size = MediaQuery.of(context).size;
    return BlocProvider<PostCubit>(
        create: (context) {
          return PostCubit();
        },
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<PostCubit, PostState>(
            builder: (context, state) {
              if (state is InitialPost) {
                var post = BlocProvider.of<PostCubit>(context);
                return Container(
                  padding: const EdgeInsets.all(20.0),
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        MapView(
                          size: size,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // ** Guiding Text **
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              ' Pick the origin and the destination of your load',
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                        const Divider(),

                        // Date Buttons
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  var date = await pickDate(context);
                                  post.pickUpDateController.text =
                                      date.toString().substring(0, 10);
                                },
                                child: const ListTile(
                                  leading: Icon(Icons.calendar_today),
                                  title: Text('Pick Up Date'),
                                  //  subtitle: Text(
                                  //      post.pickUpDateController.toString()),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  pickDate(context);
                                },
                                child: const ListTile(
                                  leading: const Icon(Icons.calendar_today),
                                  title: Text('Pick Up Date'),
                                  subtitle: Text('YYYY-MM-DD'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),

                        // truck Type and Weigth
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: dropDownButton(selectedType)),
                            const Expanded(
                              child: ListTile(
                                leading: const Icon(Icons.balance),
                                title: TextField(
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        // name and tel
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: ListTile(
                              leading: Icon(Icons.person),
                              title: TextField(),
                            )),
                            Expanded(
                                child: ListTile(
                              leading: Icon(Icons.phone),
                              title: TextField(),
                            ))
                          ],
                        ),
                        const Divider(),
                        // Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.5,
                              child: const ListTile(
                                leading: Icon(Icons.attach_money),
                                title: TextField(),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        // Description
                        const SizedBox(
                          height: 100,
                          child: Expanded(
                            child: TextField(
                              maxLines: null, // Allow multiple lines
                              decoration: InputDecoration(
                                labelText: 'Description',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // **** Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                                onPressed: () {}, child: const Text('Cancel')),
                            const SizedBox(width: 20),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('Post Load ')),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  DropdownButton<String> dropDownButton(String selectedType) {
    return DropdownButton(
      value: selectedType,
      items: [
        const DropdownMenuItem(
            value: 'Any', child: Center(child: Text('select a Truck type'))),
        DropdownMenuItem(
          value: 'berlingo',
          child: Center(
            child: Center(
              child: SvgPicture.asset(
                'assets/images/berlingo.svg',
                width: 40,
                height: 40,
                color: Colors.white60,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'camiona',
          child: Center(
            child: SvgPicture.asset(
              'assets/images/camiona.svg',
              width: 40,
              height: 40,
              color: Colors.white60,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'poid-lourd',
          child: Center(
            child: SvgPicture.asset(
              'assets/images/poid-lourd.svg',
              width: 40,
              height: 40,
              color: Colors.white60,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'trab',
          child: Center(
            child: SvgPicture.asset(
              'assets/images/trab.svg',
              width: 40,
              height: 40,
              color: Colors.white60,
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'semi',
          child: Center(
            child: SvgPicture.asset(
              'assets/images/semi.svg',
              width: 40,
              height: 40,
              color: Colors.white60,
            ),
          ),
        ),
      ],
      onChanged: (value) {
        selectedType = value!;
      },
    );
  }
}
