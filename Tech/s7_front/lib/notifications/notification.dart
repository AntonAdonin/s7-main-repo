import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:s7_front/colors/colors.dart';
import 'package:toastification/toastification.dart';

void showError(context, message) {
  toastification.show(
    alignment: Alignment.bottomCenter,
    context: context,
    style: ToastificationStyle.fillColored,
    type: ToastificationType.error,
    title: Text(message),
    autoCloseDuration: const Duration(seconds: 3),
    showProgressBar: false,
  );
}

void showMessage(context, message) {
  toastification.show(
    alignment: Alignment.bottomCenter,
    context: context,
    title: Text(message),
    autoCloseDuration: const Duration(seconds: 3),
    showProgressBar: false,
  );
}

void showSuccess(context, message) {
  toastification.show(
    alignment: Alignment.bottomCenter,
    context: context,
    primaryColor: S7Color.bitterLemon.value,
    foregroundColor: S7Color.white.value,
    backgroundColor: S7Color.sonicSilver.value,
    style: ToastificationStyle.fillColored,
    type: ToastificationType.success,
    title: Text(message),
    autoCloseDuration: const Duration(seconds: 3),
    showProgressBar: false,
  );
}
