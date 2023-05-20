import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';
import 'package:poonia_brothers/widgets/input_text.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';

class BusinessView extends StatefulWidget {
  BusinessView({Key? key, required this.data}) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  BusinessViewState createState() => BusinessViewState();
}

class BusinessViewState extends State<BusinessView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
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
                DrawerHeader(child: Image.asset("assets/logo.png")),
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (x) => SideDrawer()));
                        },
                        trailing: SizedBox(width: 0),
                        iconColor: Colors.white,
                        title: Text('Geographic hierarchy'),
                      ),
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
                          child: Text('Name:  ${widget.data.get("name")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text('Email:  ${widget.data.get("email")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text('Area:  ${widget.data.get("area")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child:
                              Text('Password:  ${widget.data.get("password")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child:
                              Text('Region:  ${widget.data.get("regionarea")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child:
                              Text('Zone:  ${widget.data.get("zonalvalue")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                              'Territory:  ${widget.data.get("territoryvalue")}'),
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
                                onPressed: alert,
                                // onPressed: () {
                                //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                //   //   backgroundColor: Colors.yellow,
                                //   //   duration: Duration(seconds: 5),
                                //   //   content: Text(
                                //   //     "${widget.data.get("name")} profile is updated successfully",
                                //   //     style: TextStyle(color: Colors.white),
                                //   //   ),
                                //   // ));
                                //   // Navigator.push(
                                //   //     context,
                                //   //     MaterialPageRoute(
                                //   //         builder: (builder) => SideDrawer()));
                                // },
                                child: Text(
                                  "Block",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Center(
                                  child: TextButton(
                                      onPressed: alert2,
                                      // onPressed: () {
                                      //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      //   //   backgroundColor: Colors.yellow,
                                      //   //   duration: Duration(seconds: 5),
                                      //   //   content: Text(
                                      //   //     "${widget.data.get("name")} profile is updated successfully",
                                      //   //     style: TextStyle(color: Colors.white),
                                      //   //   ),
                                      //   // ));
                                      //   // Navigator.push(
                                      //   //     context,
                                      //   //     MaterialPageRoute(
                                      //   //         builder: (builder) => SideDrawer()));
                                      // },
                                      child: Text(
                                        "Unblock",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ))),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, right: 20, bottom: 2),
                        //   child: Center(
                        //     child: ElevatedButton(
                        //       onPressed: () async {
                        //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //           backgroundColor: Colors.red,
                        //           duration: Duration(seconds: 5),
                        //           content: Text(
                        //             "${widget.data.get("name")} profile is deleted successfully",
                        //             style: TextStyle(color: Colors.white),
                        //           ),
                        //         ));
                        //         await _auth.currentUser!.delete();

                        //         await FirebaseFirestore.instance
                        //             .collection("business")
                        //             .doc("B65wAe8fJbPQ38o9tEKVUBaM62N2")
                        //             .delete();
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (builder) => SideDrawer()));
                        //       },
                        //       child: Text("Delete"),
                        //       style: ElevatedButton.styleFrom(
                        //           backgroundColor: Colors.red,
                        //           fixedSize:
                        //               Size(MediaQuery.of(context).size.width, 50)),
                        //     ),
                        //   ),
                        // ),
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
                      Center(child: Text("Please select one option")),
                      Image.asset(
                        "assets/png/splash.png",
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 9),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Do you want to block the user?",
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
                                    .collection("usersmanagers")
                                    .doc("${widget.data.get("uuid")}")
                                    .update({
                                  "blocked": true,
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.blue,
                                  duration: Duration(seconds: 5),
                                  content: Text(
                                    "${widget.data.get("name")} profile is blocked successfully",
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
                                    "${widget.data.get("name")} profile is still active",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => SideDrawer()));
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

  void alert2() {
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
                      Center(child: Text("Please select one option")),
                      Image.asset(
                        "assets/png/splash.png",
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 9),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Do you want to unblock the user?",
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
                                    .collection("usersmanagers")
                                    .doc("${widget.data.get("uuid")}")
                                    .update({
                                  "blocked": false,
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.blue,
                                  duration: Duration(seconds: 5),
                                  content: Text(
                                    "${widget.data.get("name")} profile is unblock successfully",
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
                                backgroundColor: Colors.green,
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
                                    "${widget.data.get("name")} profile is still blocked",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => SideDrawer()));
                              },
                              child: Text(
                                "No",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
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
}
