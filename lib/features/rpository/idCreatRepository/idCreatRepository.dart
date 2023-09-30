import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_riverpod/Providers/firebase_provider.dart';
import 'package:crud_riverpod/constant/firebaseConstant.dart';
import 'package:crud_riverpod/models/detialsModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final CreateRepositoryProvider = Provider((ref) {
  return CreateRepository(createController: ref.read(colloctionReference), storage: ref.read(imageReference));
});
final firebaseDataProvider = StreamProvider<List<DetailModel>>((ref) {
  return FirebaseFirestore.instance
      .collection(FirebaseConstant.detailsCollocation)
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return DetailModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  });
});


class CreateRepository {
  final FirebaseFirestore _createController;
  final FirebaseStorage _storage ;

  CreateRepository({

    required FirebaseFirestore createController,
    required  FirebaseStorage storage,
  }) : _createController = createController,
        _storage=storage;


  addName(DetailModel detailMode) {
    _createController
        .collection(FirebaseConstant.detailsCollocation)
        .add(detailMode.toJson())
        .then((value) => value.update({"id": value.id}));
  }

  updateDetails(DetailModel detailModel, imageUrl, address, email, firstName,
      lastName) {
    DetailModel a = detailModel.copyWith(imageUrl: imageUrl,
        address: address,
        email: email,
        firstName: firstName,
        lastName: lastName);
    _createController.collection(FirebaseConstant.detailsCollocation).
    doc(detailModel.id).update(a.toJson());
  }

  delete(DetailModel detailModel) {
    FirebaseFirestore.instance.collection(FirebaseConstant.detailsCollocation)
        .doc(detailModel.id)
        .delete();
  }

  Stream<List<DetailModel>> getDetails() {
    return _createController
        .collection(FirebaseConstant.detailsCollocation)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return DetailModel.fromJson(doc.data());
      }).toList();
    });
  }




  Future<String?> uploadImage(File file) async {
  try {
  // Get a reference to the location you want to upload to in Firebase Storage
  Reference storageReference = _storage.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');

  // Upload the file to Firebase Storage
  await storageReference.putFile(file);

  // Get the download URL
  String downloadURL = await storageReference.getDownloadURL();

  // Return the download URL
  return downloadURL;
  } catch (e) {
  print('Error uploading file: $e');
  return null;
  }
  }
}
