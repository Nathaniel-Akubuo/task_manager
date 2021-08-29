import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/services/projects_provider.dart';
import 'package:task_manager/services/util.dart';
import 'package:task_manager/widgets/color_selection_container.dart';
import 'package:task_manager/widgets/custom_textfield.dart';
import 'package:task_manager/widgets/rounded_button.dart';

class EditProjectDialog extends StatefulWidget {
  @override
  _EditProjectDialogState createState() => _EditProjectDialogState();
}

class _EditProjectDialogState extends State<EditProjectDialog> {
  var controller = TextEditingController();

  @override
  void initState() {
    controller.text = Provider.of<Util>(context, listen: false).title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var util = Provider.of<Util>(context, listen: false);
    var projects = Provider.of<ProjectsProvider>(context, listen: false);
    final _mediaQuery = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      child: Container(
        padding: EdgeInsets.all(20),
        height: _mediaQuery.height * 0.4,
        width: _mediaQuery.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ColorSelectionContainer(),
            verticalSpaceRegular,
            CustomTextFormField.regular(
              labelText: 'New title',
              autoFocus: true,
              controller: controller,
            ),
            verticalSpaceLarge,
            RoundedButton(
                onTap: () {
                  projects.updateProjectDetails(
                      context: context,
                      text: controller.text,
                      color: util.pickedColor != null
                          ? util.pickedColor.value
                          : util.color.value);
                  util.title = controller.text;
                  util.pickedColor != null
                      ? util.color = util.pickedColor
                      : util.color;
                  navigationService.back();
                },
                child: Text('SAVE', style: kAgipo))
          ],
        ),
        decoration:
            BoxDecoration(color: backgroundColor, borderRadius: kBorderRadius),
      ),
    );
  }
}
