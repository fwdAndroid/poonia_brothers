import 'package:flutter/material.dart';
import 'package:poonia_brothers/models/oreder_model.dart';
import 'package:poonia_brothers/models/product_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderDataSource extends DataGridSource {
  OrderDataSource(this.employeeData) {
    _buildDataRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<OrderModel> employeeData;

  void _buildDataRow() {
    dataGridRows = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              // DataGridCell<String>(columnName: 'uuid', value: e.uuid),
              DataGridCell<String>(
                  columnName: 'Business Manager Name', value: e.businessName),
              DataGridCell<String>(
                  columnName: 'Business Area', value: e.busnissarea),
              DataGridCell<String>(
                  columnName: 'productName', value: e.productName),
              DataGridCell<String>(columnName: 'Status', value: e.Status),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(
    DataGridRow row,
  ) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}

List<GridColumn> get getColumnsOrder {
  //   DataGridCell<String>(columnName: 'uid', value: e.id),
  // DataGridCell<String>(columnName: 'name', value: e.name),
  // DataGridCell<String>(columnName: 'gender', value: e.gender),
  // DataGridCell<String>(columnName: 'email', value: e.email),
  // DataGridCell<String>(columnName: 'dob', value: e.dob),
  // DataGridCell<String>(columnName: 'phoneNumber', value: e.phone),
  return <GridColumn>[
    GridColumn(
        columnName: 'Business Manager Name',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Business Manager Name'))),
    GridColumn(
        columnName: 'Business Area',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Business Area',
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'productName',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Product Name'))),
    GridColumn(
        columnName: 'Status ',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Status')))
  ];
}
