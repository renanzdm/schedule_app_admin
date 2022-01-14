class ConfigurationDayScheduler {
  String dateScheduler;

  int idHour;
  int id;
  int qtdScheduleOnDay;



  ConfigurationDayScheduler(
      {this.dateScheduler = '',
      this.idHour =-1,
      this.id=-1,
      this.qtdScheduleOnDay=1,
  });

 factory ConfigurationDayScheduler.fromJson(Map<String, dynamic> json) {
   return ConfigurationDayScheduler(
   dateScheduler : json['date_scheduler'],
    idHour : json['id_hour'],
    id : json['id'],
    qtdScheduleOnDay: json['qtd_of_scheduler'],

);
  }


}