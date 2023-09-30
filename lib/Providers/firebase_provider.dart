import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_riverpod/constant/firebaseConstant.dart';
import 'package:crud_riverpod/models/detialsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colloctionReference = Provider((ref) => FirebaseFirestore.instance);
final imageReference=Provider((ref) => FirebaseStorage.instance);
final fireStoreProvider=Provider((ref) => FirebaseFirestore.instance);
final authProvider = Provider((ref)  => FirebaseAuth.instance);
