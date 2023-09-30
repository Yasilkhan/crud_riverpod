import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_riverpod/Providers/firebase_provider.dart';
import 'package:crud_riverpod/constant/firebaseConstant.dart';
import 'package:crud_riverpod/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final UserSignInRepositoryProvider = Provider((ref)=>UserSignInRepository(
    firebaseFirestore: ref.read(fireStoreProvider),
    auth: ref.read(authProvider),
)
);

class UserSignInRepository{
final  FirebaseFirestore _firebaseFirestore;
final FirebaseAuth _auth;
UserSignInRepository(
    {required FirebaseFirestore firebaseFirestore,
  required FirebaseAuth auth
    }):_auth=auth,
      _firebaseFirestore=firebaseFirestore;

CollectionReference get _users=>_firebaseFirestore.collection(FirebaseConstant.users);



 newUserSignIn (String email,String password) async{
 try{
     UserModel user;
    await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) =>
    {
      user = UserModel(
        email: email,
        password: password,
        id: value.user!.uid,
      ),
      _users.doc(value.user!.uid).set(user.toMap()),
      // _users.add(user.toMap()).then((value) => value.update({"id":value.id})),
    }
  );
  }on EmailAuthCredential catch(e){
   print(e);

 }
}
loginOnUser(String email,String password){

   _auth.signInWithEmailAndPassword(email: email, password: password);
}
}