import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poonia_brothers/widgets/input_text.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';

class ProductView extends StatefulWidget {
  const ProductView(this.data, {Key? key}) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  ProductViewState createState() => ProductViewState();
}

class ProductViewState extends State<ProductView> {
  TextEditingController productController = TextEditingController();
  // TextEditingController pcsController = TextEditingController();
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
                        iconColor: Color(0xFFFFFFFF),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/png/splash.png",
                            height: 200,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                              'Product Name:  ${widget.data.get("productname")}'),
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Center(
                        //   child: Text('Product Pcs:  ${widget.data.get("pcs")}'),
                        // ),
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
                          child:
                              Text('Product Rate:  ${widget.data.get("rate")}'),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Center(
                              child: ElevatedButton(
                            onPressed: alert,
                            child: Text("Edit"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                fixedSize: Size(300, 40)),
                          )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('products')
                                .doc(widget.data.get("uuid"))
                                .delete()
                                .then((value) => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  SideDrawer()))
                                    });
                            print(widget.data.id);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 5),
                              content: Text(
                                "${widget.data.get("product name")}  is deleted successfully",
                                style: TextStyle(color: Colors.white),
                              ),
                            ));
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              fixedSize: Size(300, 40)),
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
    productController.text = widget.data.get("productname");
    dimensionController.text = widget.data.get("dimensions");
    rateController.text = widget.data.get("rate");
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
                              "Note Kindly Fill all the fields to update data")),
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
                      // const Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "Edit Pcs",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w500, fontSize: 16),
                      //   ),
                      // ),
                      // InputText(
                      //   controller: pcsController,
                      //   labelText: "${widget.data.get("pcs")}",
                      //   keyboardType: TextInputType.visiblePassword,
                      //   onChanged: (value) {},
                      //   onSaved: (val) {},
                      //   textInputAction: TextInputAction.done,
                      //   isPassword: false,
                      //   enabled: true,
                      // ),
                      // const SizedBox(height: 9),
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
                            // "pcs": pcsController.text,
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
