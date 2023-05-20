import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';
import 'package:poonia_brothers/widgets/input_text.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';

class CategoryView extends StatefulWidget {
  CategoryView({Key? key, required this.data}) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  CategoryViewState createState() => CategoryViewState();
}

class CategoryViewState extends State<CategoryView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController zoneController = TextEditingController();
  TextEditingController territoryController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.data.id);
    final FirebaseAuth _auth = FirebaseAuth.instance;

// ${widget.data.get('uid')}
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Go Back",
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      body: Row(
        children: [
          Container(
            color: Colors.white,
            width: 240,
            child: Column(
              children: [
                DrawerHeader(
                    child: Image.asset("assets/png/Poonia Crystel logo.png")),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (x) => SideDrawer()));
                        },
                        trailing: SizedBox(width: 0),
                        iconColor: Colors.white,
                        title: Text('Product Management'),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (x) => SideDrawer()));
                        },
                        trailing: SizedBox(width: 0),
                        iconColor: Colors.white,
                        title: Text('Order Management'),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (x) => SideDrawer()));
                        },
                        trailing: SizedBox(width: 0),
                        iconColor: Colors.white,
                        title: Text('User Management'),
                      ),
                      ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (x) => SideDrawer()));
                          },
                          trailing: SizedBox(width: 0),
                          iconColor: Colors.white,
                          title: Text('Geographic hierarchy')),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 340,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  height: 500,
                  width: 509.55,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/Poonia badge logo-02.svg",
                          height: 100,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text('Region:  ${widget.data.get("region")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text('Zone:  ${widget.data.get("zone")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                              'Territory:  ${widget.data.get("territory")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text('Area:  ${widget.data.get("area")}'),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Center(
                              child: TextButton(
                                onPressed: alertUpdate,
                                child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                child: Center(
                              child: TextButton(
                                onPressed: alert,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void alert() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Material(
              child: Container(
                width: 500,
                height: 300,
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/png/splash.png",
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 9),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Do you want to delete this Region Category",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 9),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("categories")
                                    .doc("${widget.data.get("uuid")}")
                                    .delete();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.blue,
                                  duration: Duration(seconds: 5),
                                  content: Text(
                                    "${widget.data.get("region")} is deleted successfully",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => SideDrawer()));
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.blue,
                                  duration: Duration(seconds: 5),
                                  content: Text(
                                    "${widget.data.get("region")} is still active",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ));
                                Navigator.pop(context);
                              },
                              child: Text(
                                "No",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void alertUpdate() {
    territoryController.text = widget.data.get("territory");
    areaController.text = widget.data.get("area");
    zoneController.text = widget.data.get("zone");
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: AlertDialog(
            title: Text('Update'),
            content: Form(
              key: _formKey,
              child: Container(
                height: 200,
                child: Column(
                  children: [
                    TextFormField(
                      controller: territoryController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Update Territory';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Please Update Territory',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: areaController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Update Area';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Please Update Area',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: zoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Update Zone';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Please Update Zone',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text('Update'),
                onPressed: () async {
                  if (areaController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.blue,
                      duration: Duration(seconds: 5),
                      content: Text(
                        "All Fields are Required",
                        style: TextStyle(color: Colors.white),
                      ),
                    ));
                    Navigator.pop(context);
                  } else {
                    await FirebaseFirestore.instance
                        .collection("categories")
                        .doc("${widget.data.get("uuid")}")
                        .update({
                      "area": areaController.text,
                      "zone": zoneController.text,
                      "territory": territoryController.text
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blue,
                        duration: Duration(seconds: 5),
                        content: Text(
                          "${widget.data.get("region")} is values is updated Successfully",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );

                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => SideDrawer()));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
