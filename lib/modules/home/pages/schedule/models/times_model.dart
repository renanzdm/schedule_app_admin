class TimesModel {
  int id;
  String time;
  int qtdSchedulerPerHour;

  TimesModel({this.id = -1, this.time = '', this.qtdSchedulerPerHour = 1});

  TimesModel copyWith({
    int? id,
    String? time,
    int? qtdSchedulerPerHour,
  }) {
    return TimesModel(
        id: id ?? this.id,
        time: time ?? this.time,
        qtdSchedulerPerHour: qtdSchedulerPerHour ?? this.qtdSchedulerPerHour);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
    };
  }

  factory TimesModel.fromMap(Map<String, dynamic> map) {
    return TimesModel(
      id: map['id'] ?? 0,
      qtdSchedulerPerHour: 1,
      time: _formatTimeExecutionService(time: map['time'] ?? ''),
    );
  }

  @override
  String toString() => 'TimesModel(id: $id, time: $time,qtdSchedulerPerHour: $qtdSchedulerPerHour)';

  static String _formatTimeExecutionService({required String time}) =>
      time.substring(0, 5);
}
