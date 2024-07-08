import 'package:flutter/material.dart';

import '../utility/app_color.dart';

class AuthCallToAction extends StatelessWidget {
  const AuthCallToAction({
    super.key,
    required this.titleText,
    required this.signupOrSigninText,
    required this.onPressed,
  });

  final String titleText;
  final String signupOrSigninText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Text(
            titleText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: onPressed,
            child: Text(
              signupOrSigninText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.appPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
