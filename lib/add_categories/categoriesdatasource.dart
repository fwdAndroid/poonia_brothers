import 'package:flutter/material.dart';
import 'package:poonia_brothers/models/category_model.dart';
import 'package:poonia_brothers/models/model.dart';
import 'package:poonia_brothers/models/oreder_model.dart';
import 'package:poonia_brothers/models/product_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CategoriesDataSource extends DataGridSource {
  CategoriesDataSource(this.employeeData) {
    _buildDataRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<CategoryModels> employeeData;

  void _buildDataRow() {
    dataGridRows = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'region', value: e.region),
              DataGridCell<String>(columnName: 'zone', value: e.zone),
              DataGridCell<String>(columnName: 'territory', value: e.territory),
              DataGridCell<String>(columnName: 'area', value: e.area),
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

List<GridColumn> get getColumnsCAt {
  //   DataGridCell<String>(columnName: 'uid', value: e.id),
  // DataGridCell<String>(columnName: 'name', value: e.name),
  // DataGridCell<String>(columnName: 'gender', value: e.gender),
  // DataGridCell<String>(columnName: 'email', value: e.email),
  // DataGridCell<String>(columnName: 'dob', value: e.dob),
  // DataGridCell<String>(columnName: 'phoneNumber', value: e.phone),
  return <GridColumn>[
    GridColumn(
        columnName: 'region',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Region'))),
    GridColumn(
        columnName: 'zone',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Zone'))),
    GridColumn(
        columnName: 'territory',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Territory'))),
    GridColumn(
        columnName: 'area',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Area',
              overflow: TextOverflow.ellipsis,
            ))),
  ];
}
