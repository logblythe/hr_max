import 'package:flutter/material.dart';
import 'package:hrmax/core/constants/constants.dart';
import 'package:hrmax/core/constants/image_paths.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/login/login_view_model.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/drop_down.dart';
import 'package:hrmax/ui/widgets/primary_button.dart';
import 'package:hrmax/ui/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  LoginViewmodel _model;

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
          resizeToAvoidBottomInset: true,
          body: Container(
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          /* CachedNetworkImage(
                            imageUrl:
                                "${ApiService.baseUrl}/company/getCompanyLogo",
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),*/
                          Image.asset(ImagePath.LOGO),
                          UIHelper.verticalSpaceLarge,
                          Dropdown(
                            options: model.clients
                                .map((client) => client.name)
                                .toList(),
                            onSelect: model.selectOrganisation,
                          ),
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
                            suffixIcon: InkWell(
                              child: Icon(Icons.remove_red_eye,
                                  color: model.obscureText
                                      ? Colors.grey
                                      : Colors.blue),
                              onTap: model.toggleObscureText,
                            ),
                            title: PASSWORD,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: model.obscureText,
                          ),
                          UIHelper.verticalSpaceLarge,
                          UIHelper.verticalSpaceMedium,
                          PrimaryButton(
                            text: LOGIN,
                            busy: model.loading,
                            onPressed: handleLogin,
                          ),
                          UIHelper.verticalSpaceLarge,
                          // Text(FORGOT_PASSWORD)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  handleLogin() {
    if (_formKey.currentState.validate()) {
      _model.login(nameController.text, passwordController.text);
    }
  }
}
