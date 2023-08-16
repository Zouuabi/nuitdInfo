import 'package:flutter/material.dart';

import '../../../../data/models/load.dart';
import '../../../shared/show_alert.dart';
import '../../../shared/choose_location_button.dart';
import 'icon_text_field.dart';
import 'pick_date_button.dart';
import '../../../shared/select_truck_type.dart';

class LoadDetailsForm extends StatefulWidget {
  const LoadDetailsForm({
    super.key,
    required this.onFormSubmited,
  });

  final void Function(Load load) onFormSubmited;

  @override
  State<LoadDetailsForm> createState() => _LoadDetailsFormState();
}

class _LoadDetailsFormState extends State<LoadDetailsForm> {
  String _pickUpDate = 'YYYY-MM-DD';
  String _dropDownDate = 'YYYY-MM-DD';
  String _truckType = 'Any';
  String _origin = 'origin';
  String _destination = 'destination';

  // Textfiled controlers

  final TextEditingController _weigthController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // variables used to control input state

  bool _nameError = false;
  bool _telError = false;
  bool _priceError = false;

  bool _checkForm() {
    bool isValid = true;

    if (_pickUpDate == 'YYYY-MM-DD' || _dropDownDate == 'YYYY-MM-DD') {
      isValid = false;
      showAlert(
          title: 'Error',
          context: context,
          message: 'Pick up date and Drop down date are both required');
    } else if (_origin == 'origin' || _destination == 'destination') {
      showAlert(
          title: 'Error',
          context: context,
          message: 'origin and destination  are both required');
    } else if (_truckType == 'Any') {
      isValid = false;
      showAlert(
          title: 'Error',
          context: context,
          message: 'You have to specify your Truck Type');
    } else if (_telController.text.length < 8) {
      isValid = false;
      setState(() {
        _telError = true;
      });
      showAlert(
          title: 'Error',
          context: context,
          message: 'Phone number must be valid exp 11 111 111');
    }

    if (_nameController.text.isEmpty) {
      isValid = false;
      setState(() {
        _nameError = true;
      });
    }

    if (_priceController.text.isEmpty) {
      isValid = false;
      setState(() {
        _priceError = true;
      });
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PickDateButton(
                  title: 'Pick Up Date',
                  onDateChanged: (date) {
                    _pickUpDate = date;
                  }),
            ),
            Expanded(
              child: PickDateButton(
                  title: 'Drop DownDate',
                  onDateChanged: (date) {
                    _dropDownDate = date;
                  }),
            ),
          ],
        ),
        const Divider(height: 30),

        Row(
          children: [
            Expanded(
              child: ChooseLocationButton(
                onlocationschanged: (location) {
                  _origin = location;
                },
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: ChooseLocationButton(
                onlocationschanged: (location) {
                  _destination = location;
                },
              ),
            ),
          ],
        ),
        const Divider(height: 30),

        // truck Type and Weigth
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            Expanded(
              flex: 2,
              child: SelectTruckType(onTypeChanged: (type) {
                _truckType = type;
              }),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: IconTextField(
                  inputController: _weigthController,
                  errorText: 'Weigth is required',
                  hint: 'Weight',
                  icon: const Icon(Icons.balance),
                  keyboard: TextInputType.number),
            ),
          ],
        ),
        const Divider(height: 30),

        // name and tel
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: IconTextField(
                  inputController: _nameController,
                  errorText: 'The name is required',
                  isError: _nameError,
                  hint: 'Your name',
                  icon: const Icon(Icons.person),
                  keyboard: TextInputType.name),
            ),
            Expanded(
                child: IconTextField(
                    inputController: _telController,
                    errorText: 'Phone number is required',
                    isError: _telError,
                    hint: 'Tel',
                    icon: const Icon(Icons.phone),
                    keyboard: TextInputType.number))
          ],
        ),
        const Divider(height: 30),

        // Price

        SizedBox(
          child: IconTextField(
            inputController: _priceController,
            errorText: 'Price is required',
            isError: _priceError,
            hint: 'price',
            icon: const Icon(Icons.attach_money),
            keyboard: TextInputType.number,
          ),
        ),

        const Divider(height: 30),
        // Description
        TextField(
          controller: _descriptionController,
          maxLines: 4, // Allow multiple lines
          decoration: const InputDecoration(
            hintText: 'Enter your load description ...',
            border: OutlineInputBorder(),
          ),
        ),
        // **** Buttons
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            const SizedBox(width: 20),
            FilledButton(
                onPressed: () {
                  if (_checkForm()) {
                    widget.onFormSubmited(Load(
                        brokerUid: '',
                        loadRef: '',
                        brokerName: _nameController.text,
                        brokerPhone: _telController.text,
                        origin: _origin.trim(),
                        destination: _destination.trim(),
                        loadDate: DateTime.now().toString().substring(0, 10),
                        pickUpDate: _pickUpDate,
                        dropDownDate: _dropDownDate,
                        truckType: _truckType,
                        price: int.parse(_priceController.text),
                        weigth: int.parse(_weigthController.text),
                        description: _descriptionController.text));
                  }
                },
                child: const Text('Post Load')),
          ],
        )
      ],
    );
  }
}
