import 'package:authentication_imp/helper/colors.dart';
import 'package:authentication_imp/helper/size_calculator.dart';
import 'package:flutter/material.dart';

class AuthenticationHeader extends StatelessWidget {
  const AuthenticationHeader({
    Key? key,
    this.backButtonFn,
    required this.titleText,
  }) : super(key: key);
  final Function? backButtonFn;
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: sizer(false, 10, context),
        ),
        Text(
          titleText,
          style: TextStyle(
            fontSize: sizer(true, 28, context),
            color: AppColors.blackColor,
            fontWeight: FontWeight.w900,
          ),
        )
      ],
    );
  }
}
