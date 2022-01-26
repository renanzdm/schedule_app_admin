import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/app/ui/widgets/text_form_field_widget.dart';
import 'package:schedule_app_admin/app/utils/mask_inputs/money_mask.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/admin_controller.dart';
import 'package:schedule_app_admin/modules/home/pages/admin/ui/widgets/services_widget.dart';
import 'package:schedule_app_admin/modules/home/pages/schedule/widgets/list_services_widget.dart';

class AddNewServices extends StatelessWidget {
  AddNewServices({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _adminController = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novos Serviços'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: PaddingDefault.screenPaddingHorizontal,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Adicione Novos Serviços',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FieldsAddNewService(
                          priceController: _priceController,
                          descriptionController: _descriptionController,
                          nameController: _nameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ServicesWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: context.themeRed,
                  fixedSize: Size(sizes.width, 40.0),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await _adminController.insertNewServices(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        price: _priceController.text);
                  }
                },
                child: const Text(
                  'Adicionar Novo Serviço',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldsAddNewService extends StatefulWidget {
  const FieldsAddNewService(
      {Key? key,
      required this.nameController,
      required this.priceController,
      required this.descriptionController})
      : super(key: key);
  final TextEditingController nameController;

  final TextEditingController priceController;

  final TextEditingController descriptionController;

  @override
  State<FieldsAddNewService> createState() => _FieldsAddNewServiceState();
}

class _FieldsAddNewServiceState extends State<FieldsAddNewService> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          TextFormFieldWidget(
            labelText: 'Nome',
            controller: widget.nameController,
            suffixIcon: Icons.person,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatorio';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormFieldWidget(
            labelText: 'Preço',
            controller: widget.priceController,
            suffixIcon: Icons.monetization_on_outlined,
            formatters: [MoneyMask()],
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatorio';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormFieldWidget(
            labelText: 'Descrição',
            controller: widget.descriptionController,
            suffixIcon: Icons.list,
            maxLines: 3,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatorio';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }
}
