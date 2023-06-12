import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poonia_brothers/models/category_model.dart';
import 'package:poonia_brothers/models/model.dart';
import 'package:poonia_brothers/models/product_model.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //UUuid mean FIreabase AuthID
  //bussiness Manager
  Future<String> managers({
    required String email,
    required String name,
    required String area,
    required String type,
    required String regionarea,
    required String password,
    required String zonalvalue,
    required String territoryvalue,
    required bool blocked,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //Add User to the database with modal

        Models userModel = Models(
          regionarea: regionarea,
          zonalvalue: zonalvalue,
          territoryvalue: territoryvalue,
          type: type,
          name: name,
          area: area,
          uuid: cred.user!.uid,
          email: email,
          password: password,
          blocked: blocked,
        );
        await firebaseFirestore
            .collection('usersmanagers')
            .doc(cred.user!.uid)
            .set(userModel.toJson());

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //add categories
  Future<String> addcategories({
    required String region,
    required String zone,
    required String area,
    required String territory,
  }) async {
    String res = 'Some error occured';

    try {
      if (region.isNotEmpty ||
          zone.isNotEmpty ||
          area.isNotEmpty ||
          territory.isNotEmpty) {
        //Add User to the database with modal

        try {
          //Add User to the database with modal
          String postId = Uuid().v1();

          CategoryModels userModel = CategoryModels(
              region: region,
              area: area,
              uuid: postId,
              zone: zone,
              territory: territory);
          final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('categories')
              .where('zone', isEqualTo: zone)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            print('The value is already added in the database.');
          } else {
            await FirebaseFirestore.instance
                .collection('categories')
                .doc(postId)
                .set(userModel.toJson());

            print('Value added successfully.');
          }

          res = 'success';
        } catch (e) {
          res = e.toString();
        }
        return res;
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Add Product
  Future<String> addProduct({
    required String dimension,
    required String uuid,
    required String productname,
    required String pcs,
    required String rate,
  }) async {
    String res = 'Some error occured';

    try {
      //Add User to the database with modal
      String postId = Uuid().v1();

      ProductModels userModel = ProductModels(
          productname: productname,
          pcs: pcs,
          uuid: postId,
          dimensions: dimension,
          rate: rate);
      await FirebaseFirestore.instance
          .collection('products')
          .doc(postId)
          .set(userModel.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
