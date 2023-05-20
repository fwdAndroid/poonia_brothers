import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModels {
  String uuid;
  String region;
  String zone;
  String territory;
  String area;

  CategoryModels({
    required this.uuid,
    required this.region,
    required this.area,
    required this.zone,
    required this.territory,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'zone': zone,
        'region': region,
        'area': area,
        'territory': territory
      };

  ///
  static CategoryModels fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return CategoryModels(
      area: snapshot['area'],
      territory: snapshot['territory'],
      uuid: snapshot['uuid'],
      zone: snapshot['zone'],
      region: snapshot['region'],
    );
  }
}
