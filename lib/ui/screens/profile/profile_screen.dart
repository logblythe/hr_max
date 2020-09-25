import 'package:flutter/material.dart';
import 'package:hrmax/network/models/login_res.dart';
import 'package:hrmax/ui/base_widget.dart';
import 'package:hrmax/ui/screens/profile/profile_viewmodel.dart';
import 'package:hrmax/ui/shared/ui_helpers.dart';
import 'package:hrmax/ui/widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewmodel _model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BaseWidget<ProfileViewmodel>(
        model: ProfileViewmodel(),
        onModelReady: (model) {
          _model = model;
        },
        builder: (context, model, child) {
          LoginRes res = model.loginRes;
          return Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNameImageRow(),
                UIHelper.verticalSpaceSmall,
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text('Branch'),
                            subtitle: Text(res.branch),
                          ),
                          Divider(thickness: 1, indent: 16),
                          ListTile(
                            title: Text('Department'),
                            subtitle: Text(res.department),
                          ),
                          Divider(thickness: 1, indent: 16),
                          ListTile(
                            title: Text('Functional Title'),
                            subtitle: Text(res.functionalTitle),
                          ),
                          Divider(thickness: 1, indent: 16),
                          ListTile(
                            title: Text('Corporate Title'),
                            subtitle: Text(res.corporateTitle),
                          ),
                          Divider(thickness: 1, indent: 16),
                          ListTile(
                            title: Text('Email'),
                            subtitle: Text(res.email),
                          ),
                          Divider(thickness: 1, indent: 16),
                          ListTile(
                            title: Text('Phone'),
                            subtitle: Text(res.phone),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  buildNameImageRow() {
    return Row(
      children: [
        ProfileImage(
          name: _model.loginRes.fullName,
          userId: _model.loginRes.idUser,
        ),
        UIHelper.horizontalSpaceMedium,
        Text(
          _model.loginRes.fullName,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
