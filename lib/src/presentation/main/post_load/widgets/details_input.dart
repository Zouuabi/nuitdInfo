import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../../data/data_source/remote_data_source/geocoding.dart';
import '../../../../data/models/load.dart';
import '../../../shared/select_truck_type.dart';
import '../../../shared/show_alert.dart';
import 'icon_text_field.dart';
import 'pick_date_button.dart';

class LoadDetailsForm extends StatefulWidget {
  const LoadDetailsForm({
    super.key,
    required this.onFormSubmited,
    required this.origin,
    required this.destination,
  });
  final void Function(Load load) onFormSubmited;
  final LatLng? origin;
  final LatLng? destination;
  @override
  State<LoadDetailsForm> createState() => _LoadDetailsFormState();
}

class _LoadDetailsFormState extends State<LoadDetailsForm> {
  String _pickUpDate = 'YYYY-MM-DD';
  String _dropDownDate = 'YYYY-MM-DD';
  String _truckType = 'Any';

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
  Future<String> toHumanReadbleAdress(LatLng location) async {
    return await PositionGeocoding.reverseGeocode(location);
  }

  bool _checkForm() {
    bool isValid = true;
    if (widget.origin == null || widget.destination == null) {
      isValid = false;
      showAlert(
          title: 'Error',
          context: context,
          message: 'The origin and the destination are both required ');
    } else if (_pickUpDate == 'YYYY-MM-DD' || _dropDownDate == 'YYYY-MM-DD') {
      isValid = false;
      showAlert(
          title: 'Error',
          context: context,
          message: 'Pick up date and Drop down date are both required');
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
              flex: 2,
              child: PickDateButton(
                  title: 'Pick Up',
                  onDateChanged: (date) {
                    _pickUpDate = date;
                  }),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              flex: 2,
              child: PickDateButton(
                  title: 'Drop down',
                  onDateChanged: (date) {
                    _dropDownDate = date;
                  }),
            ),
          ],
        ),
        const Divider(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Truck',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(width: 20),
            SelectTruckType(onTypeChanged: (type) {
              _truckType = type;
            }),
          ],
        ),
        const Divider(height: 30),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: IconTextField(
                  inputController: _weigthController,
                  errorText: 'Weigth is required',
                  hint: 'Weight',
                  icon: const Icon(Icons.balance),
                  keyboard: TextInputType.number),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              flex: 3,
              child: IconTextField(
                  inputController: _nameController,
                  errorText: 'The name is required',
                  isError: _nameError,
                  hint: 'Your name',
                  icon: const Icon(Icons.person),
                  keyboard: TextInputType.name),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),

        // name and tel
        Row(
          children: [
            Expanded(
                flex: 3,
                child: IconTextField(
                    inputController: _telController,
                    errorText: 'Phone number is required',
                    isError: _telError,
                    hint: 'Tel',
                    icon: const Icon(Icons.phone),
                    keyboard: TextInputType.number)),
            const Spacer(
              flex: 1,
            ),
          ],
        ),

        const Divider(height: 30),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: IconTextField(
                inputController: _priceController,
                errorText: 'Price is required',
                isError: _priceError,
                hint: 'price',
                icon: const Icon(Icons.attach_money),
                keyboard: TextInputType.number,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),

        const Divider(height: 30),
        // Description
        TextField(
          controller: _descriptionController,
          maxLines: 4, // Allow multiple lines
          decoration: InputDecoration(
            hintText: 'Enter your load description ...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
                onPressed: () async {
                  if (_checkForm()) {
                    String humanOrigin =
                        await toHumanReadbleAdress(widget.origin!);
                    String humanDestination =
                        await toHumanReadbleAdress(widget.destination!);
                    widget.onFormSubmited(Load(
                        origin: humanOrigin,
                        desitnation: humanDestination,
                        brokerUid: '',
                        loadRef: '',
                        brokerName: _nameController.text,
                        brokerPhone: _telController.text,
                        originLat: widget.origin!.latitude,
                        originLng: widget.origin!.longitude,
                        destinationLat: widget.destination!.latitude,
                        destinationLng: widget.destination!.longitude,
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
