
import 'package:schedule_app_admin/modules/home/models/times_model.dart';

class DateWithConfigModel {
  final String date;
  final int idConfig;
  final int qtdOfVacancy;
  final String time;
  final int idHour;

  const DateWithConfigModel( {
    required this.date,
    required this.idConfig,
    required this.qtdOfVacancy,
    required this.time,
   required  this.idHour
  });

  factory DateWithConfigModel.fromMap(Map<String, dynamic> map) {
    return DateWithConfigModel(
      idHour: map['time']['id']??-1,
      date: formatDate(map['date_scheduler'] ?? ''),
      idConfig: map['id'] ?? -1,
      qtdOfVacancy: map['qtd_of_scheduler'] ?? -1,
      time: TimesModel.formatTime(time: map['time']['time'] ?? '',),
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

}
