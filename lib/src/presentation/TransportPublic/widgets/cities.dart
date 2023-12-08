import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

final List<String> items = [
  'Tunis',
  'Sfax',
  'Sousse',
  'Kairouan',
  'Bizerte',
  'Gabès',
  'Ariana',
  'Gafsa',
  'Kasserine',
  'Monastir',
  'Tataouine',
  'Médenine',
  'Nabeul',
  'Beja',
  'Ben Arous',
  'Siliana',
  'Jendouba',
  'Mahdia',
  'Kébili',
  'La Manouba',
  'Tozeur',
  'Kef',
  'Zaghouan',
  'Sidi Bouzid',
];

class LocationButton extends StatefulWidget {
  LocationButton(
      {super.key, required this.hint, required this.onLocationSelected});
  final void Function(String) onLocationSelected;
  final String hint;
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: false,

        hint: Text(
          widget.hint,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: widget.selectedValue,
        onChanged: (value) {
          setState(() {
            widget.onLocationSelected(value!);
            widget.selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          elevation: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 145, 239, 229),
              Color.fromARGB(255, 55, 178, 166)
            ]),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 50,
          width: double.infinity,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          maxHeight: 300,
        ),

        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: widget.textEditingController,
          searchInnerWidgetHeight: 40,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 8,
              child: TextField(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                expands: false,
                maxLines: null,
                controller: widget.textEditingController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search ',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().toLowerCase().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            widget.textEditingController.clear();
          }
        },
      ),
    );
  }
}
