
import 'package:fpdart/fpdart.dart';

typedef ResultInsertNewTimes = Either<Exception,bool>;
typedef ResultDeleteTimes = Either<Exception,bool>;

abstract class AdminRepository{
Future<ResultInsertNewTimes> insertNewTimes({required String time});
Future<ResultDeleteTimes> deleteTime({required int id });

}