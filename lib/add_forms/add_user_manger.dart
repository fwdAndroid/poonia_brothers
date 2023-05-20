import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:poonia_brothers/database/db.dart';
import 'package:poonia_brothers/widgets/colors.dart';
import 'package:poonia_brothers/widgets/exc_button.dart';
import 'package:poonia_brothers/widgets/input_text.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';
import 'package:poonia_brothers/widgets/styles.dart';

class AddUserManager extends StatefulWidget {
  AddUserManager({super.key});

  @override
  State<AddUserManager> createState() => _AddUserManagerState();
}

class _AddUserManagerState extends State<AddUserManager> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _confrimPassword = TextEditingController();
  bool _isLoading = false;
  String dropdownValueRegion = "Region";
  String dropdownValue = 'Area';
  String dropdownValueZones = "Zone";
  String dropdownValueTerritory = "Territory";
  String dropdownmanagertype = "Business Manager";
  bool passwordVisible = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

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
            width: 320,
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              width: 448,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Management Platform",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 25.63),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Users
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Users",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
                          value: dropdownmanagertype,
                          // Step 4.
                          items: <String>[
                            'Business Manager',
                            'Distributor',
                            'AreaManager',
                            "Regional",
                            'Retailer',
                            'Sales Officer',
                            'Territory',
                            'Zonal'
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
                              dropdownmanagertype = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 9),
                  InputText(
                    controller: _nameController,
                    labelText: "Fawad Kaleem",
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
                      "Email Address",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 9),
                  InputText(
                    controller: _emailController,
                    labelText: "example@gmail.com",
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      validateEmail(value);
                    },
                    onSaved: (val) {},
                    textInputAction: TextInputAction.done,
                    isPassword: false,
                    enabled: true,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 9),
                            TextFormField(
                              validator: (value) {
                                // add your custom validation here.
                                if (value!.isEmpty) {
                                  return 'Please enter some text';
                                }
                                if (value.length < 3) {
                                  return 'Must be more than 2 charater';
                                }
                              },
                              controller: passController,
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                focusedBorder: AppStyles.focusedBorder,
                                disabledBorder: AppStyles.focusBorder,
                                enabledBorder: AppStyles.focusBorder,
                                errorBorder: AppStyles.focusErrorBorder,
                                focusedErrorBorder: AppStyles.focusErrorBorder,
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordVisible = !passwordVisible;
                                      },
                                    );
                                  },
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Confrim Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 9),
                            TextFormField(
                              validator: (value) {
                                // add your custom validation here.
                                if (value!.isEmpty) {
                                  return 'Please enter some text';
                                }
                                if (value.length < 3) {
                                  return 'Must be more than 2 charater';
                                }
                              },
                              controller: passController,
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                focusedBorder: AppStyles.focusedBorder,
                                disabledBorder: AppStyles.focusBorder,
                                enabledBorder: AppStyles.focusBorder,
                                errorBorder: AppStyles.focusErrorBorder,
                                focusedErrorBorder: AppStyles.focusErrorBorder,
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordVisible = !passwordVisible;
                                      },
                                    );
                                  },
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("categories")
                          .where("region")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.blue,
                          ));
                        }

                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      //Regions
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Regions",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                      const SizedBox(height: 9),

                                      Container(
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownSearch<String>(
                                            popupProps: PopupProps.menu(
                                              //to show search box

                                              showSearchBox: true,
                                              isFilterOnline: true,
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child:
                                                        Text("Search Region")),
                                              ),
                                              showSelectedItems: true,
                                              disabledItemFn: (String s) =>
                                                  s.startsWith('I'),
                                            ),
                                            items: snapshot.data!.docs
                                                .map((DocumentSnapshot
                                                    document) {
                                                  Map<String, dynamic> data =
                                                      document.data()! as Map<
                                                          String, dynamic>;
                                                  return data["region"];
                                                })
                                                .toList()
                                                .cast<String>(),
                                            selectedItem: dropdownValueRegion,
                                            onChanged: (String? day) {
                                              print(day);
                                              setState(() {
                                                dropdownValueRegion = day!;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      //Zones
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Zones",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                      const SizedBox(height: 9),
                                      //ZOnes DropDowu
                                      Container(
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownSearch<String>(
                                            popupProps: PopupProps.menu(
                                              //to show search box
                                              searchFieldProps:
                                                  TextFieldProps(),
                                              showSearchBox: true,
                                              isFilterOnline: true,
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text("Search Zone")),
                                              ),
                                              showSelectedItems: true,
                                              disabledItemFn: (String s) =>
                                                  s.startsWith('I'),
                                            ),
                                            items: snapshot.data!.docs
                                                .map((DocumentSnapshot
                                                    document) {
                                                  Map<String, dynamic> data =
                                                      document.data()! as Map<
                                                          String, dynamic>;
                                                  return data["zone"];
                                                })
                                                .toList()
                                                .cast<String>(),
                                            selectedItem: dropdownValueZones,
                                            onChanged: (String? day) {
                                              print(day);
                                              setState(() {
                                                dropdownValueZones = day!;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Territory",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                      const SizedBox(height: 9),
                                      Container(
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownSearch<String>(
                                            popupProps: PopupProps.menu(
                                              //to show search box
                                              searchFieldProps:
                                                  TextFieldProps(),
                                              showSearchBox: true,
                                              isFilterOnline: true,
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text(
                                                        "Search Territory")),
                                              ),
                                              showSelectedItems: true,
                                              disabledItemFn: (String s) =>
                                                  s.startsWith('I'),
                                            ),
                                            items: snapshot.data!.docs
                                                .map((DocumentSnapshot
                                                    document) {
                                                  Map<String, dynamic> data =
                                                      document.data()! as Map<
                                                          String, dynamic>;
                                                  return data["territory"];
                                                })
                                                .toList()
                                                .cast<String>(),
                                            selectedItem:
                                                dropdownValueTerritory,
                                            onChanged: (String? day) {
                                              print(day);
                                              setState(() {
                                                dropdownValueTerritory = day!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Area",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                      const SizedBox(height: 9),
                                      Container(
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownSearch<String>(
                                            popupProps: PopupProps.menu(
                                              //to show search box
                                              searchFieldProps:
                                                  TextFieldProps(),
                                              showSearchBox: true,
                                              isFilterOnline: true,
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text("Search Area")),
                                              ),
                                              showSelectedItems: true,
                                              disabledItemFn: (String s) =>
                                                  s.startsWith('I'),
                                            ),
                                            items: snapshot.data!.docs
                                                .map((DocumentSnapshot
                                                    document) {
                                                  Map<String, dynamic> data =
                                                      document.data()! as Map<
                                                          String, dynamic>;
                                                  return data["area"];
                                                })
                                                .toList()
                                                .cast<String>(),
                                            selectedItem: dropdownValue,
                                            onChanged: (String? day) {
                                              print(day);
                                              setState(() {
                                                dropdownValue = day!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      }),

                  const SizedBox(height: 30),
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
    );
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  void onCreate() async {
    //Area

    if (passController.text.isEmpty &&
        _emailController.text.isEmpty &&
        _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are required")));
    } else if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("email address is required")));
    } else if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("name of the user is required")));
    } else if (passController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("password is required")));
    } else {
      setState(() {
        _isLoading = true;
      });
      String rse = await DatabaseMethods().managers(
          regionarea: dropdownValueRegion,
          territoryvalue: dropdownValueTerritory,
          zonalvalue: dropdownValueZones,
          email: _emailController.text,
          password: passController.text,
          area: dropdownValue,
          name: _nameController.text,
          blocked: false,
          type: dropdownmanagertype);

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
