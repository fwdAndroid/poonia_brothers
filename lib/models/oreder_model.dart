import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderModel {
  String uuid;
  //Areas
  String businessName;
  String busnissarea;
  String productName;
  String Status;
  OrderModel(
      {required this.uuid,
      required this.businessName,
      required this.busnissarea,
      required this.Status,
      required this.productName});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'uuid': uuid,

        'productName': productName,

        'Status': Status,

        'Business Area': busnissarea,

        //Name
        'Business Manager Name': businessName,
      };

  ///
  static OrderModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return OrderModel(
      businessName: snapshot['Business Manager Name'],
      Status: snapshot['Status'],
      productName: snapshot['productName'],
      uuid: snapshot['uuid'],
      busnissarea: snapshot['Business Area'],
    );
  }
}
