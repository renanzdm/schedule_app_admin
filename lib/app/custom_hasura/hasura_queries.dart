class ScheduleQueries {
  static String get insertSchedule => r'''
  mutation insertOneSchedule($name_client: String!,$date_schedule: date,$id_hour: Int!,$service_id: Int!,$id_user: Int!){
  insert_app_schedules(objects: {name_client: $name_client, date_schedule: $date_schedule,id_hour: $id_hour, service_id: $service_id,id_user: $id_user}) {
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
    id
    id_user
    name_client
    service_id
    id_hour
  }
}''';


  static String get insertNewServices => r'''
mutation MyMutation($description: String!, $name: String!, $price: Int!) {
  insert_app_services(objects: {description: $description, name: $name, price: $price}) {
    affected_rows
  }
}
''';

  static String get insertNewTimes => r'''
mutation MyMutation($time: time!) {
  insert_app_times(objects: {time: $time}) {
    affected_rows
  }
}
''';

  static String get insertNewQtdSchedules => r'''
mutation MyMutation($date: date!, $id_hour: Int!, $qtd_of_scheduler: Int!) {
  insert_app_configuration_day_scheduler(objects: {date_scheduler: $date, id_hour: $id_hour, qtd_of_scheduler: $qtd_of_scheduler}) {
    affected_rows
  }
}
''';

  static String get deleteTimes =>r'''
mutation MyMutation($id: Int!) {
  delete_app_times(where: {id: {_eq: $id}}) {
    affected_rows
  }
}
''';

  static String get getConfigsPerDateAndHour=>r'''
query MyQuery($date: date!,$id_hour: Int!) {
  app_configuration_day_scheduler(where: {date_scheduler: {_eq: $date}, _and: {id_hour: {_eq: $id_hour}}}) {
    id
  }
}''';

  static String get updateQtdConfigDay =>r'''
mutation MyMutation($id_config: Int!,$qtd_of_scheduler: Int!) {
  update_app_configuration_day_scheduler(where: {id: {_eq: $id_config}}, _set: {qtd_of_scheduler: $qtd_of_scheduler}) {
    affected_rows
  }
}
''';

  static String get getConfigurationDaySelected =>r'''query MyQuery($date: date!) {
  app_configuration_day_scheduler(where: {date_scheduler: {_eq: $date}}) {
    date_scheduler
    id
    qtd_of_scheduler
    time {
      time
      id
    }
  }
}''';

  static String get deleteConfigPerId =>r'''
mutation MyMutation($id: Int!) {
  delete_app_configuration_day_scheduler(where: {id: {_eq: $id}}) {
    affected_rows
  }
}
''';
  static String get deleteServices=>r'''
 mutation MyMutation($id: Int!) {
  delete_app_services(where: {id: {_eq: $id}}) {
    affected_rows
  }
}
''';

static String get allScheduleSubscription=>r'''subscription schedules {
  app_schedules(order_by: {date_schedule: desc}) {
    date_schedule
    id_hour
    name_client
    service_id
    id_user
  }
}''';

}
