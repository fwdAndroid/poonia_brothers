import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poonia_brothers/database/db.dart';
import 'package:poonia_brothers/widgets/colors.dart';
import 'package:poonia_brothers/widgets/exc_button.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';
import 'package:poonia_brothers/widgets/input_text.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';
import 'package:poonia_brothers/widgets/styles.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _pcsController = TextEditingController();
  TextEditingController _dimensionController = TextEditingController();
  TextEditingController _rateController = TextEditingController();
  TextEditingController _productNameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  width: 448,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 39),

                      const Text(
                        "Product Platform",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25.63),
                      ),
                      const SizedBox(height: 60),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Product Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      InputText(
                        controller: _productNameController,
                        labelText: "Product Name",
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {},
                        onSaved: (val) {},
                        textInputAction: TextInputAction.done,
                        isPassword: false,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product name';
                          }
                          return null;
                        },
                      ),
                      // const SizedBox(height: 10),
                      // const Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     "Number of Pieces",
                      //     style:
                      //         TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      //   ),
                      // ),
                      // const SizedBox(height: 9),
                      // InputText(
                      //   controller: _pcsController,
                      //   labelText: "Pieces Number",
                      //   keyboardType: TextInputType.number,
                      //   onChanged: (value) {},
                      //   onSaved: (val) {},
                      //   textInputAction: TextInputAction.done,
                      //   isPassword: false,
                      //   enabled: true,
                      // ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Dimensions",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 9),
                      InputText(
                        controller: _dimensionController,
                        labelText: "Dimensions",
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {},
                        onSaved: (val) {},
                        textInputAction: TextInputAction.done,
                        isPassword: false,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter dimensions';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Rate",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 9),
                      TextFormField(
                        controller: _rateController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Rate",
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.background,
                          // contentPadding: EdgeInsets.all(height * 0.015),
                          focusedBorder: AppStyles.focusedBorder,
                          disabledBorder: AppStyles.focusBorder,
                          enabledBorder: AppStyles.focusBorder,
                          errorBorder: AppStyles.focusErrorBorder,
                          focusedErrorBorder: AppStyles.focusErrorBorder,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product rate';
                          }
                          return null;
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) => newValue.copyWith(
                              text: newValue.text.replaceAll('.', ','),
                            ),
                          ),
                        ],
                      ),
                      // InputText(
                      //   controller: _rateController,
                      //   labelText: "Rate",
                      //   keyboardType: TextInputType.numberWithOptions(),
                      //   onChanged: (value) {},
                      //   onSaved: (val) {},
                      //   textInputAction: TextInputAction.done,
                      //   isPassword: false,
                      //   enabled: true,
                      // ),
                      const SizedBox(height: 40),
                      WonsButton(
                        height: 50,
                        width: 348,
                        verticalPadding: 0,
                        color: Colors.red,
                        child: Text(
                          "Clear",
                          style: TextStyle(
                              color: AppColors.neutral,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        onPressed: () {
                          _dimensionController.clear();
                          _pcsController.clear();
                          _productNameController.clear();
                          _rateController.clear();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      WonsButton(
                        height: 50,
                        width: 348,
                        verticalPadding: 0,
                        color: AppColors.primary,
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : Text(
                                "Add",
                                style: TextStyle(
                                    color: AppColors.neutral,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                        onPressed: onCreate,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  var uuid = Uuid().v1();
  void onCreate() async {
    if (_productNameController.text.isEmpty &&
        _rateController.text.isEmpty &&
        _dimensionController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are required")));
    }
    if (_rateController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter rate of the product")));
    } else if (_productNameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter name of the product")));
    } else if (_dimensionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Enter dimensions of the product")));
    } else {
      setState(() {
        _isLoading = true;
      });
      String rse = await DatabaseMethods().addProduct(
        uuid: uuid,
        rate: _rateController.text,
        pcs: _pcsController.text,
        productname: _productNameController.text,
        dimension: _dimensionController.text,
      );
      print(rse);
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Conguration Data is Added")));
      Navigator.pop(context);
    }
  }
}
