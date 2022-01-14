class SchedulesModel {
  final int id;
  final String nameClient;
  final int serviceId;
  final int idHour;
  final String dateSchedule;
  SchedulesModel({
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
  }) {
    return SchedulesModel(
      id: id ?? this.id,
      nameClient: nameClient ?? this.nameClient,
      serviceId: serviceId ?? this.serviceId,
      idHour: idHour ?? this.idHour,
      dateSchedule: dateSchedule ?? this.dateSchedule,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_client': nameClient,
      'service_id': serviceId,
      'id_hour': idHour,
      'date_schedule': dateSchedule,
    };
  }

  factory SchedulesModel.fromMap(Map<String, dynamic> map) {
    return SchedulesModel(
      id: map['id'] ?? 0,
      nameClient: map['name_client'] ?? '',
      serviceId: map['service_id'] ?? 0,
      idHour: map['id_hour'] ?? 0,
      dateSchedule: map['date_schedule'] ?? '',
    );
  }

  @override
  String toString() {
    return 'SchedulesModel(id: $id, name_client: $nameClient, serviceId: $serviceId, hourInitId: $idHour, dateSchedule: $dateSchedule)';
  }
}
