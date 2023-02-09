import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/flight_controller.dart';
import 'package:frontend/design/colors.dart';
import 'package:frontend/design/fontSizes.dart';
import 'package:frontend/views/destination_view.dart';
import 'package:responsive_table/responsive_table.dart';
import '../common/flight.dart';

/*
 A View for displaying all the available Flights, which were fetched
 from the Server-side, and their details about delay, flight time, start point and
 destination, terminals and others.
 For the communication with server, it takes use of the FlightController.
 */

class FlightListView extends StatefulWidget {
  const FlightListView({Key? key}) : super(key: key);

  @override
  State<FlightListView> createState() => _FlightListViewState();
}

class _FlightListViewState extends State<FlightListView> {
  List<Flight> flights = [];

  late List<DatatableHeader> _headers;
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];
  List<bool> _expanded = [];
  bool _isLoading = true;
  bool _sortAscending = true;
  String? _sortColumn;

  @override
  void initState() {
    super.initState();

    _headers = [
      DatatableHeader(text: "Trip", value: "trip", sortable: true),
      DatatableHeader(text: "From", value: "from", sortable: true),
      DatatableHeader(text: "To", value: "to", sortable: true),
      DatatableHeader(
          text: "Departure",
          value: "start",
          sortable: true,
          sourceBuilder: (value, row) {
            late Color color;
            if (row["delayed"]! as bool) {
              color = Colors.red.shade500;
            } else {
              color = row["selected"]! as bool ? Colors.white : Colors.black;
            }
            if (value is String) {
              value = value.replaceAll('T', ' ');
            }
            return Text(
              value,
              style: TextStyle(color: color),
              textAlign: TextAlign.center,
            );
          }),
      DatatableHeader(
          text: "Arrival",
          value: "end",
          sortable: true,
          sourceBuilder: (value, row) {
            late Color color;
            if (row["delayed"]! as bool) {
              color = Colors.red.shade500;
            } else {
              color = row["selected"]! as bool ? Colors.white : Colors.black;
            }
            if (value is String) {
              value = value.replaceAll('T', ' ');
            }
            return Text(
              value,
              style: TextStyle(color: color),
              textAlign: TextAlign.center,
            );
          }),
      DatatableHeader(text: "Airline", value: "airLine", sortable: true),
    ];

    _loadFlights();
  }

  Future<void> _loadFlights() async {
    if (mounted) {
      setState(() => _isLoading = true);
    }
    flights = await FlightController.getAllFlight();
    _loadSource();
    _expanded = List.generate(_source.length, (_) => false);
    loadSelected();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void loadSelected() {
    setState(() => _selecteds =
        _source.where((flight) => flight["selected"] == true).toList());
  }

  void _loadSource() {
    _source = flights.map((flight) => flight.toJson()).toList();
  }

  void updateFlightAndReload(Map<String, dynamic> flight) async {
    if (mounted) {
      setState(() => _isLoading = true);
    }
    bool success = await FlightController.updateFlight(flight);
    if (!success) {
      showDialog(
          builder: (c) => const AlertDialog(
                title: Center(
                    child:
                        Text('Something went wrong, please try again later')),
              ),
          context: context);
      _loadFlights();
    } else {
      loadSelected();
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Browse Flights'),
          centerTitle: true,
        ),
        body: Card(
          elevation: 1,
          shadowColor: Colors.black,
          clipBehavior: Clip.none,
          child: ResponsiveDatatable(
            isLoading: _isLoading,
            headers: _headers,
            source: _source,
            selecteds: _selecteds,
            showSelect: false, // buggy?
            autoHeight: false,
            dropContainer: (data) => _DropDown(
              flightAsMap: data,
              tableState: this,
            ),
            onSort: (value) {
              setState(() => _isLoading = true);

              setState(() {
                _sortColumn = value;
                _sortAscending = !_sortAscending;

                if (_sortAscending) {
                  _source.sort((a, b) =>
                      b["$_sortColumn"]!.compareTo(a["$_sortColumn"]));
                } else {
                  _source.sort((a, b) =>
                      a["$_sortColumn"]!.compareTo(b["$_sortColumn"]));
                }
                _isLoading = false;
              });
            },
            expanded: _expanded,
            sortAscending: _sortAscending,
            sortColumn: _sortColumn,
            //onSelect: (v, i){},
            //onSelectAll: (v){},
            //footers: const [],
            headerDecoration: BoxDecoration(
                color: Colors.blue.shade700,
                border: const Border(
                    bottom: BorderSide(color: Colors.black, width: 0.5))),
            selectedDecoration: const BoxDecoration(
              color: CustomColors.BLUE_THEME,
            ),
            headerTextStyle: const TextStyle(color: Colors.white),
            rowTextStyle: const TextStyle(color: Colors.black),
            selectedTextStyle: const TextStyle(color: Colors.white),
          ),
        ));
  }
}

class _DropDown extends StatefulWidget {
  final Map<String, dynamic> flightAsMap;
  final _FlightListViewState tableState;
  const _DropDown(
      {Key? key, required this.flightAsMap, required this.tableState})
      : super(key: key);

  @override
  State<_DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<_DropDown> {
  @override
  Widget build(BuildContext context) {
    final String flightNum = widget.flightAsMap["flightNum"] as String;
    final bool selected = widget.flightAsMap["selected"] as bool;
    final String selectButtonText =
        selected ? "Remove from Trip" : "Add to Trip";
    final int terminal = widget.flightAsMap["terminal"] as int;
    final String gate = widget.flightAsMap["gate"] as String;
    final int seat = widget.flightAsMap["seat"] as int;
    final String airplaneType = widget.flightAsMap["airplaneType"] as String;

    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 2),
                left: BorderSide(color: Colors.grey.shade300),
                right: BorderSide(color: Colors.grey.shade300))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Flight Number: $flightNum"),
                    Text("Terminal: $terminal"),
                    Text("Gate: $gate"),
                    Text("Seat: $seat"),
                    Text("Airplane Type: $airplaneType")
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (selected) {
                          widget.flightAsMap["selected"] = false;
                          widget.flightAsMap["trip"] = "";
                          widget.tableState
                              .updateFlightAndReload(widget.flightAsMap);
                        } else {
                          showDialog(
                              context: context,
                              builder: (c) =>
                                  AddToTripDialog(widget.flightAsMap)).then(
                              (value) => widget.tableState
                                  .updateFlightAndReload(widget.flightAsMap));
                        }
                      },
                      color: selected ? Colors.red.shade800 : Colors.green,
                      padding: const EdgeInsets.all(12),
                      minWidth: MediaQuery.of(context).size.width / 6,
                      child: Text(
                        selectButtonText,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: FontSizes.extraSmall(context),
                            color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => DestinationView(
                                  widget.flightAsMap['to'] as String))),
                      color: Colors.blue.shade800,
                      padding: const EdgeInsets.all(12),
                      minWidth: MediaQuery.of(context).size.width / 6,
                      child: Text(
                        "Destination Information",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: FontSizes.extraSmall(context),
                            color: Colors.white),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}

class AddToTripDialog extends StatefulWidget {
  final Map<String, dynamic> flight;
  const AddToTripDialog(this.flight, {Key? key}) : super(key: key);

  @override
  State<AddToTripDialog> createState() => _AddToTripDialogState();
}

class _AddToTripDialogState extends State<AddToTripDialog> {
  String? tripName;
  Set<String>? availableTrips;

  @override
  void initState() {
    super.initState();
    loadTripNames();
  }

  void loadTripNames() async {
    final flights = await FlightController.getSelected();
    setState(() => availableTrips = flights.map((e) => e.trip).toSet());
  }

  @override
  Widget build(BuildContext context) {
    late Widget title;
    if (availableTrips == null) {
      title = const Center(
          child: CircularProgressIndicator(color: CustomColors.MAIN_THEME));
    } else {
      title = Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Center(
                child: Text('Create a new Trip or select an existing one'))),
        Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter the the name of a new Trip',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onSubmitted: (value) => setState(() {
                      tripName = value;
                      availableTrips!.add(value);
                    }))),
        DropdownButton<String>(
          isExpanded: true,
          value: tripName,
          underline: Container(
            height: 2,
            color: CustomColors.MAIN_THEME,
          ),
          items: availableTrips!
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: (newVal) => setState(() => tripName = newVal ?? ""),
        ),
      ]);
    }

    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: title,
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.red.shade700,
          child: const Text('Cancel'),
        ),
        MaterialButton(
          disabledColor: Colors.grey,
          onPressed: tripName?.isEmpty ?? true
              ? null
              : () {
                  widget.flight['trip'] = tripName!;
                  widget.flight['selected'] = true;
                  Navigator.pop(context);
                },
          color: Colors.green.shade600,
          child: const Text('Add'),
        )
      ],
    );
  }
}
