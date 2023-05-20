import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModels {
  String uuid;
  String productname;
  String dimensions;
  String rate;
  String? pcs;

  ProductModels({
    required this.uuid,
    required this.productname,
    this.pcs,
    required this.dimensions,
    required this.rate,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'dimensions': dimensions,
        'productname': productname,
        'pcs': pcs,
        'rate': rate
      };

  ///
  static ProductModels fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return ProductModels(
      pcs: snapshot['pcs'],
      rate: snapshot['rate'],
      uuid: snapshot['uuid'],
      dimensions: snapshot['dimensions'],
      productname: snapshot['productname'],
    );
  }
}
