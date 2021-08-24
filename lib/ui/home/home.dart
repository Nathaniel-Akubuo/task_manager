import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/authentication.dart';

import 'home_view_model.dart';

class Home extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Authentication>(context, listen: false);
    final _mediaQuery = MediaQuery.of(context).size;
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                key: model.scaffoldKey,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add, size: 30),
                  backgroundColor: blue,
                  onPressed: () {},
                ),
                backgroundColor: backgroundColor,
                drawer: Drawer(),
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.apps),
                    onPressed: () => model.openDrawer(),
                  ),
                  title: Text(
                    'Sunday, 22',
                    style: kPoppins.copyWith(fontSize: 22),
                  ),
                  actions: [
                    Center(
                      child: IconButton(
                          icon: Icon(FontAwesomeIcons.calendarAlt, size: 22),
                          onPressed: () => auth.logout(context)),
                    ),
                    horizontalSpaceRegular
                  ],
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: kPadding,
                  child: Column(
                    children: [
                      verticalSpaceMedium,
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(20)),
                      )
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
