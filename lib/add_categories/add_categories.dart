import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poonia_brothers/add_categories/show_categores.dart';
import 'package:poonia_brothers/dashboard/order_management.dart';
import 'package:poonia_brothers/dashboard/user_manager.dart';
import 'package:poonia_brothers/database/db.dart';
import 'package:poonia_brothers/product/product.dart';
import 'package:poonia_brothers/widgets/colors.dart';
import 'package:poonia_brothers/widgets/exc_button.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';
import 'package:poonia_brothers/widgets/input_text.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';
import 'package:poonia_brothers/widgets/styles.dart';
import 'package:uuid/uuid.dart';
import 'package:email_validator/email_validator.dart';

class AddCategories extends StatefulWidget {
  AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  TextEditingController _zoneControlr = TextEditingController();
  TextEditingController _territoryContolerller = TextEditingController();
  TextEditingController _areaControtller = TextEditingController();
  bool _isLoading = false;
  String dropdownValueRegion = "Punjab";

  bool passwordVisible = false;
  String _errorMessage = '';

  var gujranwalaTerritory = [];
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
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
          SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    const Text(
                      "Add Categories Platform",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 25.63),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //Users
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter Region Address",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    //Users
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)),
                      height: 50,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            isDense: true,
                            underline: SizedBox(
                              height: 0,
                            ),
                            // Step 3.
                            value: dropdownValueRegion,
                            // Step 4.
                            items: <String>[
                              'Punjab',
                              'Sindh',
                              'KPK',
                              "Balochistan",
                              'Gilgit Baltistan',
                              'Kashmir',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            // Step 5.
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValueRegion = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter Zone Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: _zoneControlr,
                      labelText: "Lahore",
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
                        "Enter Territory Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: _territoryContolerller,
                      labelText: "Gujjar Khan",
                      keyboardType: TextInputType.text,
                      onSaved: (val) {},
                      textInputAction: TextInputAction.done,
                      isPassword: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 10),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter Area Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: _areaControtller,
                      labelText: "Gujjar Khan",
                      keyboardType: TextInputType.text,
                      onSaved: (val) {},
                      textInputAction: TextInputAction.done,
                      isPassword: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 10),

                    const SizedBox(height: 40),
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
                    SizedBox(
                      height: 10,
                    ),
                    WonsButton(
                      height: 50,
                      width: 348,
                      verticalPadding: 0,
                      color: Colors.red,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : Text(
                              "Clear",
                              style: TextStyle(
                                  color: AppColors.neutral,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                      onPressed: () {
                        _areaControtller.clear();
                        _territoryContolerller.clear();
                        _zoneControlr.clear();
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onCreate() async {
    //Area

    if (_zoneControlr.text.isEmpty &&
        _territoryContolerller.text.isEmpty &&
        _areaControtller.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are required")));
    } else if (_zoneControlr.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("zone address is required")));
    } else if (_territoryContolerller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("territory address is required")));
    } else if (_areaControtller.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("area address is required")));
    } else {
      setState(() {
        _isLoading = true;
      });
      String rse = await DatabaseMethods().addcategories(
        region: dropdownValueRegion,
        area: _areaControtller.text,
        territory: _territoryContolerller.text,
        zone: _zoneControlr.text,
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
