import 'package:flutter/material.dart';
import 'package:poonia_brothers/models/product_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductDataSource extends DataGridSource {
  ProductDataSource(this.employeeData) {
    _buildDataRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<ProductModels> employeeData;

  void _buildDataRow() {
    dataGridRows = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              // DataGridCell<String>(columnName: 'uuid', value: e.uuid),
              DataGridCell<String>(
                  columnName: 'productname', value: e.productname),
              DataGridCell<String>(
                  columnName: 'dimensions', value: e.dimensions),
              // DataGridCell<String>(columnName: 'pcs', value: e.pcs),
              DataGridCell<String>(columnName: 'rate', value: e.rate),
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

List<GridColumn> get getColumns {
  //   DataGridCell<String>(columnName: 'uid', value: e.id),
  // DataGridCell<String>(columnName: 'name', value: e.name),
  // DataGridCell<String>(columnName: 'gender', value: e.gender),
  // DataGridCell<String>(columnName: 'email', value: e.email),
  // DataGridCell<String>(columnName: 'dob', value: e.dob),
  // DataGridCell<String>(columnName: 'phoneNumber', value: e.phone),
  return <GridColumn>[
    GridColumn(
        columnName: 'productname',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Product Name'))),
    GridColumn(
        columnName: 'dimensions',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Dimensions',
              overflow: TextOverflow.ellipsis,
            ))),
    // GridColumn(
    //     columnName: 'pcs',
    //     label: Container(
    //         padding: const EdgeInsets.all(8.0),
    //         alignment: Alignment.center,
    //         child: const Text('Number of pcs'))),
    GridColumn(
        columnName: 'rate',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Rate')))
  ];
}
