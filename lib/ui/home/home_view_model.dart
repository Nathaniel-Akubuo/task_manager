import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/widgets/modal_bottom_sheet.dart';

class HomeViewModel extends BaseViewModel {
  showBottomSheet(context) => showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      context: context,
      builder: (context) => ModalBottomSheet());
}
