class SchedulesModel {
  final int id;
  final String nameClient;
  final int serviceId;
  final int idHour;
  final String dateSchedule;
  final String nameService;
  final String hour;
  final bool finished;
  SchedulesModel({
    this.nameService = '',
    this.hour = '',
    this.id = -1,
    this.nameClient = '',
    this.serviceId = -1,
    this.idHour = -1,
    this.dateSchedule = '',
    this.finished=false
  });

  SchedulesModel copyWith({
    int? id,
    String? nameClient,
    int? serviceId,
    int? idHour,
    String? dateSchedule,
    String? nameService,
    String? hour,
    bool? finished,
  }) {
    return SchedulesModel(
      id: id ?? this.id,
      nameClient: nameClient ?? this.nameClient,
      serviceId: serviceId ?? this.serviceId,
      idHour: idHour ?? this.idHour,
      dateSchedule: dateSchedule ?? this.dateSchedule,
      nameService: nameService ??this.nameService,
      hour:  hour ??this.hour,
      finished: finished??this.finished
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
      dateSchedule: _formatDate(map['date_schedule'] ?? ''),
      nameService: map['name_service'] ?? '',
      hour: map['hour'] ?? '',
      finished: _setIfScheduleIsFinished(map['date_schedule']),
    );
  }

  static String _formatDate(String date) {
    String value = '';
    if (date.isNotEmpty) {
      var listSplit = date.split('-');
      value += listSplit[2] + '-' + listSplit[1] + '-' + listSplit[0];
    }
    return value;
  }

 static _setIfScheduleIsFinished(String date){
     int year = 0;
     int month = 0;
     int day = 0;
    if (date.isNotEmpty) {
      var listSplit = date.split('-');
      year = int.tryParse(listSplit[0]) ??0; 
      month=int.tryParse(listSplit[1])??0;
      day = int.tryParse(listSplit[2])??0;
    }
   return DateTime.now().isBefore(DateTime(year,month,day));
  }

  

  @override
  String toString() {
    return 'SchedulesModel(id: $id, nameClient: $nameClient, serviceId: $serviceId, idHour: $idHour, dateSchedule: $dateSchedule, nameService: $nameService, hour: $hour, finished: $finished)';
  }
}
