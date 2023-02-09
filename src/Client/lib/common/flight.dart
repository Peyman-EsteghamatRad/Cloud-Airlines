class Flight {
  String from,
      to,
      startTime,
      endTime,
      gate,
      airline,
      airplaneType,
      flightNum,
      trip;
  int terminal, seat, idflights;
  bool selected, delayed;
  double fromLat, fromLng, toLat, toLng;

  Flight(
      {required this.idflights,
      required this.flightNum,
      required this.from,
      required this.to,
      required this.startTime,
      required this.endTime,
      required this.gate,
      required this.airline,
      required this.airplaneType,
      required this.terminal,
      required this.seat,
      required this.delayed,
      required this.selected,
      required this.trip,
      required this.fromLat,
      required this.fromLng,
      required this.toLat,
      required this.toLng});

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
        idflights: json['idflights'],
        flightNum: json['flightNum'],
        from: json['from'],
        to: json['to'],
        startTime: json['start'],
        endTime: json['end'],
        gate: json['gate'],
        airline: json['airLine'],
        airplaneType: json['airplaneType'],
        terminal: json['terminal'],
        seat: json['seat'],
        delayed: json['delayed'],
        selected: json['selected'],
        trip: json['trip'],
        fromLat: json['fromLat'],
        fromLng: json['fromLng'],
        toLat: json['toLat'],
        toLng: json['toLng']);
  }

  Map<String, dynamic> toJson() {
    return {
      'idflights': idflights,
      'flightNum': flightNum,
      'selected': selected,
      'from': from,
      'to': to,
      'start': startTime,
      'end': endTime,
      'gate': gate,
      'airLine': airline,
      'airplaneType': airplaneType,
      'terminal': terminal,
      'seat': seat,
      'delayed': delayed,
      'trip': trip,
      'fromLat': fromLat,
      'fromLng': fromLng,
      'toLat': toLat,
      'toLng': toLng
    };
  }
}
