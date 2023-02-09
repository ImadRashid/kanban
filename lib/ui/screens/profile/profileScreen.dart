import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:karbanboard/core/others/base_view_model.dart';
import 'package:karbanboard/ui/screens/profile/profileScreenProvider.dart';
import 'package:provider/provider.dart';

import '../../../core/restart_app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProfileScreenProvider(),
        child:
            Consumer<ProfileScreenProvider>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    model.logout(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout_rounded),
                      Text("Logout"),
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }
}
