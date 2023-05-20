import 'package:flutter/material.dart';
import 'package:poonia_brothers/models/model.dart';
import 'package:poonia_brothers/models/oreder_model.dart';
import 'package:poonia_brothers/models/product_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserMaangerDataSource extends DataGridSource {
  UserMaangerDataSource(this.employeeData) {
    _buildDataRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<Models> employeeData;

  void _buildDataRow() {
    dataGridRows = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'area', value: e.area),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'password', value: e.password),
              DataGridCell<String>(columnName: 'type', value: e.type),
              DataGridCell(columnName: 'blocked', value: e.blocked)
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

List<GridColumn> get getColumnsBusiness {
  //   DataGridCell<String>(columnName: 'uid', value: e.id),
  // DataGridCell<String>(columnName: 'name', value: e.name),
  // DataGridCell<String>(columnName: 'gender', value: e.gender),
  // DataGridCell<String>(columnName: 'email', value: e.email),
  // DataGridCell<String>(columnName: 'dob', value: e.dob),
  // DataGridCell<String>(columnName: 'phoneNumber', value: e.phone),
  return <GridColumn>[
    GridColumn(
        columnName: 'name',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Name'))),
    GridColumn(
        columnName: 'Area',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Area',
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'Email',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Email'))),
    GridColumn(
        columnName: 'Password ',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Password'))),
    GridColumn(
        columnName: 'type ',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Type'))),
    GridColumn(
        columnName: 'blocked ',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Block')))
  ];
}
