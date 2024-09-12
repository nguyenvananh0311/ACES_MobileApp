import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  const PhoneNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "${localization!.phoneNumber}:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Chỉ cho phép nhập số
                ],
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  // errorText: _validatePhoneNumber(controller.text) ? null : localization.phoneNumberError,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Hàm kiểm tra số điện thoại
  bool _validatePhoneNumber(String value) {
    // Định dạng cơ bản của số điện thoại (bạn có thể thay đổi theo yêu cầu)
    String pattern = r'^(?:[+0]9)?[0-9]{10,12}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
