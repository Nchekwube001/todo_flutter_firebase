import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/features/authentication/data/auth_repository.dart';
import 'package:flutter_todo/utils/app_styles.dart';
import 'package:flutter_todo/utils/size_config.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Account',
            style: AppStyles.titleTextStyle.copyWith(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Account Information',
              style: AppStyles.headingTextStyle,
            ),
            Icon(
              Icons.account_circle,
              size: 60,
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            Text(
              "${currentUser.email!}",
              style: AppStyles.normalTextStyle,
            ),
            SizedBox(height: 4),
            Text(
              "${currentUser.uid!}",
              style: AppStyles.normalTextStyle,
            ),
            SizedBox(
              height: SizeConfig.getProportionateHeight(20),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getProportionateWidth(20)),
              child: InkWell(
                onTap: () {
                  ref.read(authRepositoryProvider).signOut();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: SizeConfig.getProportionateHeight(50),
                  width: SizeConfig.deviceWidth,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Log Out',
                      style: AppStyles.normalTextStyle
                          .copyWith(color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
