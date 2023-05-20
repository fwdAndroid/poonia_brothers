import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';
import 'package:poonia_brothers/widgets/input_text.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';

class OrderView extends StatefulWidget {
  const OrderView(this.data, {Key? key}) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  OrderViewState createState() => OrderViewState();
}

class OrderViewState extends State<OrderView> {
  TextEditingController productController = TextEditingController();
  TextEditingController pcsController = TextEditingController();
  TextEditingController dimensionController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.data.id);

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
            mainAxisAlignment: MainAxisAlignment.center,
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
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Image.asset(
                        //     "assets/png/splash.png",
                        //     height: 200,
                        //   ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                              'Product Name:  ${widget.data.get("productName")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child:
                              Text('Product Pcs:  ${widget.data.get("PCS")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                              'Product Dimensions:  ${widget.data.get("dimensions")}'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                              'Business Manager Name:  ${widget.data.get("Business Manager Name")}'),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: Text(
                              'Retailer Name:  ${widget.data.get("RetailerName")}'),
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 2),
                          child: Center(
                            child: TextButton(
                                onPressed: () async {
                                  print("deete");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 5),
                                    content: Text(
                                      "${widget.data.get("uuid")}  is completed successfully",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ));
                                  await FirebaseFirestore.instance
                                      .collection("orders")
                                      .doc(widget.data.get("uuid"))
                                      .update({"Status": "Complete"});
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => SideDrawer()));
                                },
                                child: Text("Mark as Complete"),
                                style: TextButton.styleFrom()),
                          ),
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
                height: 550,
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                              "Note Kindly Fill all the fields to upadate data")),
                      Image.asset(
                        "assets/png/splash.png",
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 9),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Edit Product Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      InputText(
                        labelText: "${widget.data.get("productname")} ",
                        controller: productController,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {},
                        onSaved: (val) {},
                        textInputAction: TextInputAction.done,
                        isPassword: false,
                        enabled: true,
                      ),
                      const SizedBox(height: 9),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Edit Pcs",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      InputText(
                        controller: pcsController,
                        labelText: "${widget.data.get("pcs")}",
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {},
                        onSaved: (val) {},
                        textInputAction: TextInputAction.done,
                        isPassword: false,
                        enabled: true,
                      ),
                      const SizedBox(height: 9),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Edit Dimensions",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      InputText(
                        controller: dimensionController,
                        labelText: "${widget.data.get("dimensions")}",
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                        onSaved: (val) {},
                        textInputAction: TextInputAction.done,
                        isPassword: false,
                        enabled: true,
                      ),
                      const SizedBox(height: 9),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Edit Rate",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      InputText(
                        controller: rateController,
                        labelText: "${widget.data.get("rate")}",
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {},
                        onSaved: (val) {},
                        textInputAction: TextInputAction.done,
                        isPassword: false,
                        enabled: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("products")
                              .doc("${widget.data.get("uuid")}")
                              .update({
                            "productname": productController.text,
                            "pcs": pcsController.text,
                            "dimensions": dimensionController.text,
                            "rate": rateController.text
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            duration: Duration(seconds: 5),
                            content: Text(
                              "${widget.data.get("productname")} profile is updated successfully",
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => SideDrawer()));
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: StadiumBorder(),
                            fixedSize: Size(300, 40)),
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
