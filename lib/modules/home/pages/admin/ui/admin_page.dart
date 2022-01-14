import 'package:flutter/material.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';

import 'widgets/card_options_admin.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: PaddingDefault.screenPaddingHorizontal,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Gerencie as opções de seu agendamento',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      CardOptionsAdmin(
                        height: sizes.height * .2,
                        width: sizes.width * .4,
                        icon: Icons.alarm_add,
                        title: 'Adicionar Novos Horários',
                        onTap: () {
                          Navigator.of(context).pushNamed('/add_hours');
                        },
                      ),
                      CardOptionsAdmin(
                        height: sizes.height * .2,
                        width: sizes.width * .4,
                        icon: Icons.post_add,
                        title: 'Adicionar novas vagas',
                        onTap: () {
                          Navigator.of(context).pushNamed('/add_vacancy');
                        },
                      ),
                      CardOptionsAdmin(
                        height: sizes.height * .2,
                        width: sizes.width * .4,
                        icon: Icons.shopping_cart_outlined,
                        title: 'Adicionar novos serviços',
                        onTap: () {
                          Navigator.of(context).pushNamed('/add_services');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
