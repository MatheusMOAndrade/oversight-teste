import 'package:get_it/get_it.dart';
import 'package:oversight/api/endpoints.dart';
import 'package:oversight/navigation/navigation.dart';
import 'package:oversight/stores/auth/auth_cubit.dart';
import 'package:oversight/use_cases/auth_use_case.dart';

import '../../../constants/app_image_asset.dart';
import '../../../presentation/widgets/buttons/button/oversight_button.dart';
import '../../../presentation/widgets/buttons/button/oversight_button_style.dart';
import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

class OversightDrawer extends StatefulWidget {
  const OversightDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<OversightDrawer> createState() => _OversightDrawerState();
}

class _OversightDrawerState extends State<OversightDrawer> {
  late final AuthCubit _cubit;

  @override
  void initState() {
    _cubit = GetIt.I.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: OversightColors.cultured,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 140,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: OversightColors.primaryCian,
                shape: BoxShape.rectangle,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image(
                  image: AssetImage(
                    AppImageAsset.logoDrawer,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: OversightButton(
          //     icon: Icons.settings,
          //     title: 'Configurações',
          //     style: const OversightButtonStyle(
          //       backgroundColor: OversightColors.secondaryCian,
          //       iconSize: 20,
          //       borderRadius: 20.0,
          //       textStyle: OversightTextStyles.kEyebrowStrong,
          //     ),
          //     onPressed: () {},
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OversightButton(
              icon: Icons.logout,
              title: 'Sair',
              style: const OversightButtonStyle(
                backgroundColor: OversightColors.secondaryCian,
                iconSize: 20,
                borderRadius: 20.0,
                textStyle: OversightTextStyles.kEyebrowStrong,
              ),
              onPressed: () async {
                await _cubit.signOut();

                navigator?.pushNamed(Endpoints.login);
              },
            ),
          ),

          // Add more list items as needed.
        ],
      ),
    );
  }
}
