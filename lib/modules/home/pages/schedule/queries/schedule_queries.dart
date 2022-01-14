class ScheduleQueries {
  static String get insertSchedule => r'''
  mutation insertOneSchedule($name_client: String!,$date_schedule: date,$hour_finish_id: Int!,$hour_init_id: Int!,$service_id: Int!,$id_user: String!){
  insert_app_schedules(objects: {name_client: $name_client, date_schedule: $date_schedule, hour_finish_id: $hour_finish_id,
    hour_init_id: $hour_init_id, service_id: $service_id,id_user: $id_user}) {
    affected_rows
  }
}
  ''';

  static String get getServices => r'''
 query GetServices {
  app_services {
    description
    id
    name
    price
    time_execution
  }
}''';

  static String get getAllTimes => r'''
query GetTimes{
  app_times(order_by: {time: asc}) {
    id
    time
  }
}
''';

  static String get getSchedulesByDate => r'''
query MyQuery($date: date!) {
  app_schedules(where: {date_schedule: {_eq: $date}}, order_by: {date_schedule: asc}) {
    date_schedule
    hour_finish_id
    hour_init_id
    id
    id_user
    name_client
    service_id
  }
}''';

  static String get getConfigurationDayScheduler => r'''
query GetConfigurationDayScheduler($date: date!) {
  app_configuration_day_scheduler(where: {date_scheduler: {_eq: $date}}) {
    hour_finish_id
    hour_init_id
    date_scheduler
    qtd_of_scheduler
    id
  }
}
''';
}
