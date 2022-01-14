import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/service/shared_preferences_service.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/app/ui/widgets/text_form_field_widget.dart';
import 'package:schedule_app_admin/app/utils/mask_inputs/phone_mask.dart';
import 'package:schedule_app_admin/app/utils/utils.dart';
import './register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  RegisterPage({Key? key}) : super(key: key);

  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _nameController = TextEditingController(text: '');
  final _phoneController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: PaddingDefault.screenPaddingHorizontal,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            height: sizes.height,
            width: sizes.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  height: sizes.height * .25,
                ),
                RegisterContent(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    registerController: controller,
                    phoneController: _phoneController,
                    nameController: _nameController,
                    sizes: sizes),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterContent extends StatelessWidget {
  const RegisterContent({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController phoneController,
    required TextEditingController nameController,
    required RegisterController registerController,
    required this.sizes,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        _registerController = registerController,
        _phoneController = phoneController,
        _nameController = nameController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _phoneController;
  final TextEditingController _nameController;
  final RegisterController _registerController;
  final Size sizes;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(12),
      color: context.backgroundColorMinOpacity,
      shadowColor: Colors.grey.shade800,
      elevation: 5,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget(
                    controller: _emailController,
                    labelText: 'E-mail',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatorio';
                      } else if (!Utils.regexEmail().hasMatch(value)) {
                        return 'Este email não é válido';
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: Icons.mail_outline),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget.password(
                  isPasswordField: true,
                  controller: _passwordController,
                  labelText: 'Senha',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatorio';
                    } else if (value.length < 8) {
                      return 'Digite uma senha com no minimo 8 caracters';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget(
                    controller: _nameController,
                    labelText: 'Name',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatorio';
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: Icons.person_outline),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget(
                    formatters: [PhoneMask()],
                    controller: _phoneController,
                    labelText: 'Telefone',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatorio';
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: Icons.phone_enabled_sharp),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: context.themeRed,
                    fixedSize: Size(sizes.width, 40.0),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      var response = await _registerController.registerFirebase(
                          email: _emailController.text,
                          password: _passwordController.text,
                          name: _nameController.text,
                          phone: _phoneController.text
                              .replaceAll(RegExp(r'\D'), ''));
                      if (response != null) {
                        SharedPreferencesService _sharedPreferences =
                            Get.find<SharedPreferencesService>();
                        await _sharedPreferences.clearPreferences();
                        await _sharedPreferences.setUserModel(user: response);
                        await Future.delayed(const Duration(seconds: 3));
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      }
                    }
                  },
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
