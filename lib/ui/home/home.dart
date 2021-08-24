import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/authentication.dart';
import 'package:task_manager/widgets/project_bubble.dart';
import 'package:task_manager/widgets/to_do_bubble.dart';

import 'home_view_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Authentication>(context, listen: false);
    final _mediaQuery = MediaQuery.of(context).size;
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Monday, 28',
                    style: kAgipo.copyWith(fontSize: 20, letterSpacing: 1.5),
                  ),
                  actions: [
                    Center(
                      child: IconButton(
                          icon: Icon(FontAwesomeIcons.calendarAlt, size: 18),
                          onPressed: () => auth.logout(context)),
                    ),
                    horizontalSpaceRegular
                  ],
                ),
                drawer: Drawer(),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: kPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMedium,
                      Container(
                        height: _mediaQuery.height * 0.225,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      verticalSpaceRegular,
                      Text('Projects',
                          style: kAgipo.copyWith(
                              fontSize: 20, letterSpacing: 1.5)),
                      verticalSpaceRegular,
                      Container(
                        height: _mediaQuery.height * 0.225,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ProjectBubble(),
                          itemCount: 10,
                        ),
                      ),
                      verticalSpaceLarge,
                      Text('Tasks',
                          style: kAgipo.copyWith(
                              fontSize: 20, letterSpacing: 1.5)),
                      verticalSpaceRegular,
                      ToDoBubble(
                          title: 'Take the coat to dry cleaning',
                          onChecked: (v) {},
                          onDismissed: (d) {},
                          keyValue: 'keyValue',
                          onTap: () {},
                          isDone: false),
                      ToDoBubble(
                          title: "Help with Sam's project",
                          onChecked: (v) {},
                          onDismissed: (d) {},
                          keyValue: 'keyValue',
                          onTap: () {},
                          isDone: false),
                      ToDoBubble(
                          title: "Fix Mom's bike",
                          onChecked: (v) {},
                          onDismissed: (d) {},
                          keyValue: 'keyValue',
                          onTap: () {},
                          isDone: false),
                      verticalSpaceLarge,
                      verticalSpaceLarge,
                    ],
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add, size: 30),
                  backgroundColor: blue,
                  onPressed: () {},
                ),
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
