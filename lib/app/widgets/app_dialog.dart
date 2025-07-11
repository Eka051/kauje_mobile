import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppDialog {
  static Future<void> showSuccessDialog({
    Widget? child,
    bool barrierDismissible = true,
  }) async {
    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showErrorDialog({
    String? title,
    String? message,
    String buttonText = 'OK',
    VoidCallback? onOk,
    bool barrierDismissible = true,
  }) async {
    await Get.dialog(
      AlertDialog(
        title: title != null ? Text(title) : null,
        content: message != null ? Text(message) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              if (onOk != null) onOk();
            },
            child: Text(buttonText),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<bool?> showConfirmationDialog({
    String? title,
    String? message,
    String confirmText = 'Ya',
    String cancelText = 'Batal',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: title != null ? Text(title) : null,
        content: message != null ? Text(message) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
              if (onCancel != null) onCancel();
            },
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
              if (onConfirm != null) onConfirm();
            },
            child: Text(confirmText),
          ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}
