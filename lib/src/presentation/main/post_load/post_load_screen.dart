import 'package:doft/src/presentation/shared/text_field.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/date_picker.dart';
import '../../shared/map_view.dart';

class PostLoadScreen extends StatelessWidget {
  const PostLoadScreen({super.key});



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
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
                  DropdownButton(items: [
                    DropdownMenuItem(child: Text('dfsd')),
                  ], onChanged: (value) {}),
                  SizedBox(
                    width: size.width * 0.3,
                    child: MyTextField(
                        labelText: 'Weigth',
                        errorMessage: 'fvc',
                        keyboardType: TextInputType.number,
                        icon: null,
                        controller: TextEditingController(),
                        hintText: 'Weight',
                        isError: false),
                  ),
                ],
              ),
              const Divider(),
              // name and tel
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: MyTextField(
                        labelText: 'Name',
                        errorMessage: 'fvc',
                        keyboardType: TextInputType.text,
                        icon: null,
                        controller: TextEditingController(),
                        hintText: 'Enter Your Name',
                        isError: false),
                  ),
                  SizedBox(
                    width: size.width * 0.3,
                    child: MyTextField(
                        labelText: 'Tel',
                        errorMessage: 'fvc',
                        keyboardType: TextInputType.number,
                        icon: null,
                        controller: TextEditingController(),
                        hintText: 'Tel',
                        isError: false),
                  ),
                ],
              ),
              const Divider(),
              // Price
              SizedBox(
                width: size.width * 0.3,
                child: MyTextField(
                    labelText: 'Price',
                    errorMessage: 'fvc',
                    keyboardType: TextInputType.number,
                    icon: null,
                    controller: TextEditingController(),
                    hintText: 'Tel',
                    isError: false),
              ),
              const Divider(),
              // Description
              SizedBox(
                width: size.width * 0.5,
                child: MyTextField(
                    labelText: 'Decription',
                    errorMessage: '',
                    keyboardType: TextInputType.text,
                    icon: null,
                    controller: TextEditingController(),
                    hintText: 'Description',
                    isError: false),
              ),
              const SizedBox(
                height: 20,
              ),
              // **** Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Post Load ')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
