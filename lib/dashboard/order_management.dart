import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poonia_brothers/datasource/order_data_source.dart';
import 'package:poonia_brothers/datasource/product_data_source.dart';
import 'package:poonia_brothers/models/oreder_model.dart';
import 'package:poonia_brothers/models/product_model.dart';
import 'package:poonia_brothers/product/product_view.dart';
import 'package:poonia_brothers/view/order_view.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:poonia_brothers/view/bussiness_view.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:poonia_brothers/dashboard/user_manager.dart';
import 'package:poonia_brothers/dashboard/order_management.dart';

import 'package:poonia_brothers/product/product.dart';

class OrderManagement extends StatefulWidget {
  const OrderManagement({super.key});

  @override
  State<OrderManagement> createState() => _OrderManagementState();
}

class _OrderManagementState extends State<OrderManagement> {
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
            decoration: InputDecoration(label: Text('Search By Product Name')),
            onFieldSubmitted: (_) {
              setState(() {
                isShowUser = true;
              });
            },
          )),
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
                          .collection("orders")
                          .where("productName",
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
                                    builder: (context) => OrderView(
                                          data,
                                        )));
                              },
                              title: Text(documents[index]['productName']),
                              subtitle: Text(documents[index]['Business Area']),
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

  late OrderDataSource employeeDataSource;
  List<OrderModel> employeeData = [];

  final getDataFromFireStore =
      FirebaseFirestore.instance.collection('orders').snapshots();
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
                    columnName: 'productName', value: data.doc['productName']),
                DataGridCell<String>(
                    columnName: 'Business Manager Name',
                    value: data.doc['Business Manager Name']),
                DataGridCell<String>(
                    columnName: 'Business Area',
                    value: data.doc['Business Area']),
                DataGridCell<String>(
                    columnName: 'Status', value: data.doc['Status']),
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
              employeeData.add(OrderModel(
                uuid: data['uuid'],
                Status: data['Status'],
                productName: data['productName'],
                businessName: data['Business Manager Name'],
                busnissarea: data['Business Area'],
              ));
            }
            employeeDataSource = OrderDataSource(employeeData);
          }

          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: SfDataGrid(
              allowFiltering: true,
              allowSorting: true,
              allowSwiping: true,
              source: employeeDataSource,
              columns: getColumnsOrder,
              columnWidthMode: ColumnWidthMode.fill,
              onCellTap: (details) {
                if (details.rowColumnIndex.rowIndex != 0) {
                  final DataGridRow row = employeeDataSource
                      .effectiveRows[details.rowColumnIndex.rowIndex - 1];
                  int index = employeeDataSource.dataGridRows.indexOf(row);
                  var data = snapshot.data!.docs[index];
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => OrderView(data)));
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
