class SchedulesModel {
  final int id;
  final String nameClient;
  final int serviceId;
  final int idHour;
  final String dateSchedule;
  final String nameService;
  final String hour;
  SchedulesModel({
    this.nameService = '',
    this.hour = '',
    this.id = -1,
    this.nameClient = '',
    this.serviceId = -1,
    this.idHour = -1,
    this.dateSchedule = '',
  });

  SchedulesModel copyWith({
    int? id,
    String? nameClient,
    int? serviceId,
    int? idHour,
    String? dateSchedule,
    String? nameService,
    String? hour,
  }) {
    return SchedulesModel(
      id: id ?? this.id,
      nameClient: nameClient ?? this.nameClient,
      serviceId: serviceId ?? this.serviceId,
      idHour: idHour ?? this.idHour,
      dateSchedule: dateSchedule ?? this.dateSchedule,
      nameService: nameService ??this.nameService,
      hour:  hour ??this.hour
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_client': nameClient,
      'service_id': serviceId,
      'id_hour': idHour,
      'date_schedule': dateSchedule,
      'name_service':nameService,
      'hour':hour
    };
  }

  factory SchedulesModel.fromMap(Map<String, dynamic> map) {
    return SchedulesModel(
      id: map['id'] ?? 0,
      nameClient: map['name_client'] ?? '',
      serviceId: map['service_id'] ?? 0,
      idHour: map['id_hour'] ?? 0,
      dateSchedule: formatDate(map['date_schedule'] ?? ''),
      nameService: map['name_service'] ?? '',
      hour: map['hour'] ?? '',
    );
  }

  static String formatDate(String date) {
    String value = '';
    if (date.isNotEmpty) {
      var listSplit = date.split('-');
      value += listSplit[2] + '-' + listSplit[1] + '-' + listSplit[0];
    }
    return value;
  }

  @override
  String toString() {
    return 'SchedulesModel(id: $id, nameClient: $nameClient, serviceId: $serviceId, idHour: $idHour, dateSchedule: $dateSchedule, nameService: $nameService, hour: $hour)';
  }
}
