import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/core/constants/image_paths.dart';
import 'package:hrmax/core/services/api_service.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/login/login_view_model.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/primary_button.dart';
import 'package:hrmax/ui/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: "superadmin");
  final passwordController = TextEditingController(text: "1234");
  LoginViewmodel _model;

  handleLogin() {
    if (_formKey.currentState.validate()) {
      _model.login(nameController.text, passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewmodel>(
      model: LoginViewmodel(),
      onModelReady: (model) async {
        _model = model;
        model.init();
      },
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
                        CachedNetworkImage(
                          imageUrl: "${ApiService.baseUrl}/company/getCompanyLogo",
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        UIHelper.verticalSpaceLarge,
                        UIHelper.verticalSpaceLarge,
                        TextInput(
                          prefixIcon: Icon(Icons.verified_user),
                          title: USERNAME,
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        UIHelper.verticalSpaceLarge,
                        TextInput(
                          prefixIcon: Icon(Icons.lock),
                          title: PASSWORD,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        UIHelper.verticalSpaceLarge,
                        UIHelper.verticalSpaceMedium,
                        PrimaryButton(
                            text: LOGIN,
                            busy: model.loading,
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
