import 'package:flutter/material.dart';
import 'package:produk/main.dart';

void main() => runApp(const ListViewExampleApp());

class ListViewExampleApp extends StatelessWidget {
  const ListViewExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListTileSelectExample(),
    );
  }
}

class ListTileSelectExample extends StatefulWidget {
  const ListTileSelectExample({super.key});

  @override
  ListTileSelectExampleState createState() => ListTileSelectExampleState();
}

class ListTileSelectExampleState extends State<ListTileSelectExample> {
  bool isSelectionMode = false;
  final int listLength = 9;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;

  static var selectedList;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Produk',
        ),
        leading: isSelectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    isSelectionMode = false;
                  });
                  initializeSelection();
                },
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    // ignore: prefer_const_constructors
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
        actions: <Widget>[
          if (_isGridMode)
            IconButton(
              icon: const Icon(Icons.grid_on),
              onPressed: () {
                setState(() {
                  _isGridMode = false;
                });
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                setState(() {
                  _isGridMode = true;
                });
              },
            ),
          if (isSelectionMode)
            TextButton(
              child: !_selectAll
                  ? const Text(
                      'select all',
                      style: TextStyle(color: Colors.white),
                    )
                  : const Text(
                      'unselect all',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                _selectAll = !_selectAll;
                setState(() {
                  _selected =
                      List<bool>.generate(listLength, (_) => _selectAll);
                });
              },
            ),
        ],
      ),
      body: SafeArea(
        child: _isGridMode
            ? GridBuilder(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              )
            : ListBuilder(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              ),
      ),
    );
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    Key? key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  }) : super(key: key);

  final bool isSelectionMode;
  final Function(bool)? onSelectionChange;
  final List<bool> selectedList;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.selectedList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (_, int index) {
        return CustomListItem(
          index: index,
          isSelectionMode: widget.isSelectionMode,
          onToggle: _toggle,
        );
      },
    );
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    Key? key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  }) : super(key: key);

  final bool isSelectionMode;
  final List<bool> selectedList;
  final Function(bool)? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.selectedList.length,
      itemBuilder: (_, int index) {
        return CustomListItem(
          index: index,
          isSelectionMode: widget.isSelectionMode,
          onToggle: _toggle,
        );
      },
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.index,
    required this.isSelectionMode,
    required this.onToggle,
  }) : super(key: key);

  final int index;
  final bool isSelectionMode;
  final Function(int) onToggle;

  static const List<String> bandoList = [
    '08',
    '2 cagak',
    '20 DN',
    '3 daun',
    '30',
    '35',
    '47',
    '50',
    '75',
  ];

  static const List<String> hargaList = [
    'Rp. 2.000',
    'Rp. 3.000',
    'Rp. 1.000',
    'Rp. 2.000',
    'Rp. 2.000',
    'Rp. 2.000',
    'Rp. 3.000',
    'Rp. 3.000',
    'Rp. 7.000',
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var selectedList;
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () => onToggle(index),
        onLongPress: () {
          if (!isSelectionMode) {
            onToggle(index);
          }
        },
        trailing: isSelectionMode
            ? Checkbox(
                value: ListTileSelectExampleState.selectedList[index],
                onChanged: (bool? x) => onToggle((x ?? false) as int),
              )
            : IconButton(
                onPressed: () {
                  print('Hapus item ${index + 1}');
                },
                icon: const Icon(Icons.delete),
              ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  'Bando ${getBandoDetails(index)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              'Harga: ${getHargaDetails(index)}',
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  static String getBandoDetails(int index) {
    return bandoList[index];
  }

  static String getHargaDetails(int index) {
    return hargaList[index];
  }
}

mixin selectedList {}

// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables