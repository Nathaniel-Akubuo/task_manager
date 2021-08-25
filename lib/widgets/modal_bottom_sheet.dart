import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/constants/global_variables.dart';
import 'package:task_manager/constants/styles.dart';
import 'package:task_manager/constants/ui_helpers.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/services/tasks_provider.dart';
import 'package:task_manager/widgets/custom_textfield.dart';
import 'package:task_manager/widgets/rounded_button.dart';

class ModalBottomSheet extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var task = Provider.of<TasksProvider>(context, listen: false);
    final _mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom * 0.8),
      child: Container(
        padding: kPadding,
        height: _mediaQuery.height * 0.4,
        child: Column(
          children: [
            verticalSpaceLarge,
            CustomTextFormField.regular(
              autoFocus: true,
              controller: controller,
            ),
            verticalSpaceLarge,
            RoundedButton(
                onTap: () {
                  task.addToDo(TaskModel(
                      dateCreated: DateTime.now(),
                      item: controller.text,
                      isChecked: false));
                  navigationService.back();
                },
                child: Text('ADD', style: kAgipo))
          ],
        ),
      ),
    );
  }
}
