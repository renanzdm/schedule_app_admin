import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';
import 'package:schedule_app_admin/app/utils/utils.dart';
import 'package:schedule_app_admin/modules/home/ui/home_controller.dart';


class ServiceItemWidget extends StatelessWidget {
  final String name;
  final int price;
  final String description;
  final int id;

  ServiceItemWidget(
      {Key? key,
      required this.name,
      required this.price,
      required this.description,
      required this.id})
      : super(key: key);
  final _homeControlle = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return AnimatedContainer(
        key: UniqueKey(),
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInCirc,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _homeControlle.serviceIdSelected.value == id
                ? <BoxShadow>[
                    const BoxShadow(
                      color: Colors.black,
                      offset: Offset(4.0, 6.0),
                      blurRadius: 2,
                    )
                  ]
                : <BoxShadow>[]),
        height: _homeControlle.serviceIdSelected.value == id ? 80 : 75,
        width: _homeControlle.serviceIdSelected.value == id
            ? width
            : width - 30,
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          color: _homeControlle.serviceIdSelected.value == id
              ? context.themeRed
              : Colors.white,
          child: InkWell(
             borderRadius:BorderRadius.circular(12),
            onTap: () async {
              _homeControlle.setIdServiceSelected(id: id);
          
            },
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Utils.formatForMoney(price: price),
                      style: TextStyle(
                          color:
                              _homeControlle.serviceIdSelected.value == id
                                  ? Colors.white
                                  : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),

                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color:
                                _homeControlle.serviceIdSelected.value ==
                                        id
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          color:
                              _homeControlle.serviceIdSelected.value == id
                                  ? Colors.white
                                  : Colors.black54,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 3,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
