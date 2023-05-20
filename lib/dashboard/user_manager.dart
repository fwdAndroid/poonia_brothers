import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poonia_brothers/add_forms/add_user_manger.dart';
import 'package:poonia_brothers/datasource/user_managers_data_source.dart';
import 'package:poonia_brothers/models/model.dart';
import 'package:poonia_brothers/view/bussiness_view.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:poonia_brothers/dashboard/user_manager.dart';
import 'package:poonia_brothers/dashboard/order_management.dart';

import 'package:poonia_brothers/product/product.dart';

class UserManager extends StatefulWidget {
  const UserManager({super.key});

  @override
  State<UserManager> createState() => _UserManagerState();
}

class _UserManagerState extends State<UserManager> {
  TextEditingController controller = TextEditingController();
  bool isShowUser = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Image.asset("assets/png/Poonia Crystel logo.png"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isShowUser = true;
                  });
                },
                icon: Icon(Icons.search))
          ],
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: TextFormField(
            controller: controller,
            decoration: InputDecoration(label: Text('Search By Name')),
            onFieldSubmitted: (_) {
              setState(() {
                isShowUser = true;
              });
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => AddUserManager()));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 670,
              child: isShowUser
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("usersmanagers")
                          .where("name",
                              isGreaterThanOrEqualTo: controller.text)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...');
                        }

                        List<DocumentSnapshot> documents = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () {
                                var data = snapshot.data!.docs[index];

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BusinessView(
                                          data: data,
                                        )));
                              },
                              title: Text(documents[index]['name']),
                              subtitle: Text(documents[index]['email']),
                            );
                          },
                        );
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: _buildDataGrid(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  late UserMaangerDataSource employeeDataSource;
  List<Models> employeeData = [];

  final getDataFromFireStore =
      FirebaseFirestore.instance.collection('usersmanagers').snapshots();
  Widget _buildDataGrid() {
    return StreamBuilder(
      stream: getDataFromFireStore,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LoadingAnimationWidget.hexagonDots(
                  color: Colors.blue, size: 200));
        }
        if (snapshot.hasData) {
          if (employeeData.isNotEmpty) {
            getDataGridRowFromDataBase(DocumentChange<Object?> data) {
              return DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'name', value: data.doc['name']),
                DataGridCell<String>(
                    columnName: 'email', value: data.doc['email']),
                DataGridCell<String>(
                    columnName: 'password', value: data.doc['password']),
                DataGridCell<String>(
                    columnName: 'type', value: data.doc['type']),
                DataGridCell<String>(
                    columnName: 'area', value: data.doc['area']),
              ]);
            }

            for (var data in snapshot.data!.docChanges) {
              if (data.type == DocumentChangeType.modified) {
                if (data.oldIndex == data.newIndex) {
                  employeeDataSource.dataGridRows[data.oldIndex] =
                      getDataGridRowFromDataBase(data);
                }
                employeeDataSource.updateDataGridSource();
              } else if (data.type == DocumentChangeType.added) {
                employeeDataSource.dataGridRows
                    .add(getDataGridRowFromDataBase(data));
                employeeDataSource.updateDataGridSource();
              } else if (data.type == DocumentChangeType.removed) {
                employeeDataSource.dataGridRows.removeAt(data.oldIndex);
                employeeDataSource.updateDataGridSource();
              }
            }
          } else {
            for (var data in snapshot.data!.docs) {
              employeeData.add(Models(
                territoryvalue: data['territoryvalue'],
                regionarea: data['regionarea'],
                zonalvalue: data['zonalvalue'],
                uuid: data['uuid'],
                name: data['name'],
                email: data['email'],
                password: data['password'],
                type: data['type'],
                area: data['area'],
                blocked: data['blocked'],
              ));
            }
            employeeDataSource = UserMaangerDataSource(employeeData);
          }

          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: SfDataGrid(
              allowFiltering: true,
              allowSorting: true,
              allowSwiping: true,
              source: employeeDataSource,
              columns: getColumnsBusiness,
              columnWidthMode: ColumnWidthMode.fill,
              onCellTap: (details) {
                if (details.rowColumnIndex.rowIndex != 0) {
                  final DataGridRow row = employeeDataSource
                      .effectiveRows[details.rowColumnIndex.rowIndex - 1];
                  int index = employeeDataSource.dataGridRows.indexOf(row);
                  var data = snapshot.data!.docs[index];
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BusinessView(data: data)));
                }
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
