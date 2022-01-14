import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

import 'package:schedule_app_admin/app/ui/icons_custom_icons.dart';
import 'package:schedule_app_admin/app/ui/theme_default/padding_default.dart';
import 'package:schedule_app_admin/app/ui/widgets/text_form_field_widget.dart';
import 'package:schedule_app_admin/app/utils/utils.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _loginController = Get.find<LoginController>();

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
                LoginContent(
                    sizes: sizes,
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    loginController: _loginController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({
    Key? key,
    required this.sizes,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required LoginController loginController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        _loginController = loginController,
        super(key: key);

  final Size sizes;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final LoginController _loginController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizes.width * .9,
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(12),
        color: context.backgroundColorMinOpacity,
        shadowColor: Colors.grey.shade800,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget(
                  labelText: 'E-mail',
                  controller: _emailController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatorio';
                    } else if (!Utils.regexEmail().hasMatch(value)) {
                      return 'Este email não é válido';
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: Icons.mail_outline,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget.password(
                  isPasswordField: true,
                  labelText: 'Senha',
                  controller: _passwordController,
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
                ElevatedButton(
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: context.themeRed,
                    fixedSize: Size(sizes.width, 40.0),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      var response =
                          await _loginController.loginEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);
                      if (response!=null) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false);
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: context.themeRed,
                    fixedSize: Size(sizes.width, 40.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child:
                      const Text('Criar Conta', style: TextStyle(fontSize: 20)),
                ),

                const SizedBox(
                  height: 10,
                ),
                //TODO: Fazer essa funcao na api
                // TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     'Esqueceu senha?',
                //     style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
