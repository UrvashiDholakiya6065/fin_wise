import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseInstanceClass {


  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static UserCredential? userCredential;

}