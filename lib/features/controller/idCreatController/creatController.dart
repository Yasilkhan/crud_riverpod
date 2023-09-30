import 'dart:io';

import 'package:crud_riverpod/features/rpository/idCreatRepository/idCreatRepository.dart';
import 'package:crud_riverpod/models/detialsModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final CreateControllerProvider = Provider((ref) {
  return CreateController(createRepository: ref.read(CreateRepositoryProvider));
});

class CreateController {
  final CreateRepository _createRepository;
  CreateController({required CreateRepository createRepository})
      : _createRepository = createRepository;

  addName(DetailModel detailModel) {
    _createRepository.addName(detailModel);
  }
  updateDetails(DetailModel detailModel,imageUrl,address,email,firstName,lastName){
    _createRepository.updateDetails(detailModel,imageUrl,address,email,firstName,lastName);
  }

  delete(DetailModel detailModel){
    _createRepository.delete(detailModel);
  }


  Stream<List<DetailModel>> getDetails(){

    return _createRepository.getDetails();

  }

}
