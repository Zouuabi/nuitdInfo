import 'package:doft/src/presentation/main/post_load/cubits/post_load_state.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(InitialPost());

  final TextEditingController weigthController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pickUpDateController = TextEditingController();
  final TextEditingController dropDwonDateController = TextEditingController();

  String? truckType;

  void postLoad() {
    emit(InitialPost());

    if (weigthController.text.isEmpty) {
      emit(PostError(errrorMessage: 'weigth is empty'));
    } else if (nameController.text.isEmpty) {
      emit(PostError(errrorMessage: 'name is empty'));
    } else if (telController.text.isEmpty) {
      emit(PostError(errrorMessage: 'tel is empty'));
    } else if (priceController.text.isEmpty) {
      emit(PostError(errrorMessage: 'price is empty'));
    } else if (descriptionController.text.isEmpty) {
      emit(PostError(errrorMessage: 'description is empty'));
    } else {
      // send Load to the firestore
  
    }
  }
}
