import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poonia_brothers/datasource/product_data_source.dart';
import 'package:poonia_brothers/models/product_model.dart';
import 'package:poonia_brothers/product/add_product.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poonia_brothers/product/product_view.dart';
import 'package:poonia_brothers/widgets/sidebar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:poonia_brothers/dashboard/user_manager.dart';
import 'package:poonia_brothers/dashboard/order_management.dart';
import 'package:poonia_brothers/product/product.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class _ProductState extends State<Product> {
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
    BestTutorSite _site = BestTutorSite.javatpoint;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => AddProduct()));
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
                          .collection("products")
                          .where("productname",
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
                                    builder: (context) => ProductView(
                                          data,
                                        )));
                              },
                              title: Text(documents[index]['productname']),
                              subtitle: Text(documents[index]['rate']),
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

  late ProductDataSource employeeDataSource;
  List<ProductModels> employeeData = [];

  final getDataFromFireStore =
      FirebaseFirestore.instance.collection('products').snapshots();
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
                // DataGridCell<String>(
                //     columnName: 'uuid', value: data.doc['uuid']),
                DataGridCell<String>(
                    columnName: 'productname', value: data.doc['productname']),
                DataGridCell<String>(
                    columnName: 'dimensions', value: data.doc['dimensions']),
                // DataGridCell<String>(columnName: 'pcs', value: data.doc['pcs']),
                DataGridCell<String>(
                    columnName: 'rate', value: data.doc['rate']),
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
              employeeData.add(ProductModels(
                uuid: data['uuid'],
                productname: data['productname'],
                dimensions: data['dimensions'],
                pcs: data['pcs'],
                rate: data['rate'],
              ));
            }
            employeeDataSource = ProductDataSource(employeeData);
          }

          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: SfDataGrid(
              allowFiltering: true,
              allowSorting: true,
              allowSwiping: true,
              source: employeeDataSource,
              columns: getColumns,
              columnWidthMode: ColumnWidthMode.fill,
              onCellTap: (details) {
                if (details.rowColumnIndex.rowIndex != 0) {
                  final DataGridRow row = employeeDataSource
                      .effectiveRows[details.rowColumnIndex.rowIndex - 1];
                  int index = employeeDataSource.dataGridRows.indexOf(row);
                  var data = snapshot.data!.docs[index];
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductView(data)));
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
