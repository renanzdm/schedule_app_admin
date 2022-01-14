import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/handler_messages/handler_messages.dart';
import 'package:schedule_app_admin/app/ui/loader/loader_mixin.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/models/times_model.dart';
import 'package:schedule_app_admin/modules/home/services/home_service.dart';

class HomeController extends GetxController with LoaderMixin, MessageMixin  {
  final HomeService _homeService;

  HomeController({required HomeService homeService})
      : _homeService = homeService;


  final _loading = Rx<bool>(false);
  final _messages = Rxn<MessageModel>();
  RxList<TimesModel> listOfTimesDefault = RxList<TimesModel>([]);
  RxString errorGetTimes = RxString('');


  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_messages);
  }

  @override
  void onReady()async{
    await getTimes();
  }




  Future<List<TimesModel>> getTimes() async {
    _loading(true);
    var res = await _homeService.getTimes();
    _loading(false);
    res.fold((l) {
      errorGetTimes.value = l.error;
    }, (r) {
      listOfTimesDefault.clear();
      errorGetTimes.value = '';
      listOfTimesDefault.addAll(r);
    });
    return listOfTimesDefault;
  }






}