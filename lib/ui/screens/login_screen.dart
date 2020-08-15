import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/core/constants/image_paths.dart';
import 'package:hrmax/core/view_models/login_view_model.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/primary_button.dart';
import 'package:hrmax/ui/widgets/text_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginViewModel _model;

  handleLogin() {
    if (_formKey.currentState.validate()) {
      _model.login(nameController.text, passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(navigationService: Provider.of(context)),
      onModelReady: (model) => _model = model,
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          ImagePath.LOGO,
                        ),
                        UIHelper.verticalSpaceLarge,
                        UIHelper.verticalSpaceLarge,
                        TextInput(
                          prefixIcon: Icon(Icons.verified_user),
                          title: USERNAME,
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        UIHelper.verticalSpaceMedium,
                        TextInput(
                          prefixIcon: Icon(Icons.lock),
                          title: PASSWORD,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        UIHelper.verticalSpaceLarge,
                        PrimaryButton(
                            text: LOGIN,
                            busy: model.busy,
                            onPressed: handleLogin),
                        UIHelper.verticalSpaceLarge,
                        Text(FORGOT_PASSWORD)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
