import 'package:cloud_firestore/cloud_firestore.dart';

class Models {
  String uuid;
  String password;
  String email;
  String area;
  String type;
  String regionarea;
  String zonalvalue;
  String territoryvalue;
  String name;
  bool blocked;

  Models({
    required this.uuid,
    required this.password,
    required this.type,
    required this.email,
    required this.area,
    required this.regionarea,
    required this.zonalvalue,
    required this.territoryvalue,
    required this.name,
    required this.blocked,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'name': name,
        "territoryvalue": territoryvalue,
        'uuid': uuid,
        'email': email,
        'password': password,
        'type': type,
        'area': area,
        'blocked': blocked,
        'zonalvalue': zonalvalue,
        'regionarea': regionarea
      };

  ///
  static Models fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return Models(
        type: snapshot['type'],
        territoryvalue: snapshot['territoryvalue'],
        area: snapshot['area'],
        name: snapshot['name'],
        uuid: snapshot['uuid'],
        email: snapshot['email'],
        zonalvalue: snapshot['zonalvalue'],
        regionarea: snapshot['regionarea'],
        password: snapshot['password'],
        blocked: snapshot['blocked']);
  }
}
