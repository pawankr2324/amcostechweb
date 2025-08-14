import 'package:amcostechweb/core/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 68,
            width: 64,
            child: TextFormField(
              onChanged: (val) {
                if (val.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (otpText1) {},
              style: AppTextStyles().titleMedium,
              keyboardType: TextInputType.numberWithOptions(),
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
