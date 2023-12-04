import '../../../constants/app_image_asset.dart';
import '../../../presentation/widgets/buttons/button/oversight_button.dart';
import '../../../presentation/widgets/buttons/button/oversight_button_style.dart';
import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

class OversightDrawer extends StatelessWidget {
  const OversightDrawer({
    Key? key,
  }) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OversightButton(
              icon: Icons.settings,
              title: 'Configurações',
              style: const OversightButtonStyle(
                backgroundColor: OversightColors.secondaryCian,
                iconSize: 20,
                borderRadius: 20.0,
                textStyle: OversightTextStyles.kEyebrowStrong,
              ),
              onPressed: () {},
            ),
          ),
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
              onPressed: () {},
            ),
          ),

          // Add more list items as needed.
        ],
      ),
    );
  }
}
