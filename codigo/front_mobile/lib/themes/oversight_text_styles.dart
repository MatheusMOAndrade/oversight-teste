import '../../../../themes/oversight_colors.dart';
import 'package:flutter/material.dart';

class OversightTextStyles {
  final TextStyle skyline;
  final TextStyle skylineBlue;
  final TextStyle skylineSubheader;
  final TextStyle skylineSupportiveText;
  final TextStyle h1;
  final TextStyle eyebrowStrong;
  final TextStyle tagStrong;
  final TextStyle tag;
  final TextStyle buttonTitle;
  final TextStyle captionStrong;
  final TextStyle captionHighlighted;
  final TextStyle caption;
  final TextStyle captionMini;

  const OversightTextStyles({
    this.skyline = kSkyline,
    this.skylineBlue = kSkylineBlue,
    this.skylineSubheader = OversightTextStyles.kSkylineSubheader,
    this.skylineSupportiveText = kSkylineSupportiveText,
    this.h1 = kH1,
    this.eyebrowStrong = kEyebrowStrong,
    this.tagStrong = kTagStrong,
    this.tag = kTag,
    this.buttonTitle = kButtonTitle,
    this.captionStrong = kCaptionStrong,
    this.captionHighlighted = kCaptionHighlighted,
    this.caption = kCaption,
    this.captionMini = kCaptionMini,
  });

  static const kSkyline = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 60,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.16,
  );
  static const kSkylineBlue = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: OversightColors.primaryBlue,
    height: 1.16,
  );
  static const kSkylineSubheader = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 40,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.25,
  );
  static const kSkylineSupportiveText = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 30,
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 5 / 3,
  );
  static const kH1 = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.5,
  );
  static const kEyebrowStrong = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: OversightColors.grey,
    height: 1.5,
  );
  static const kTagStrong = TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.08,
      color: OversightColors.black,
      height: 1.42,
      overflow: TextOverflow.ellipsis);
  static const kTagLightStrong = TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.7,
      color: OversightColors.white,
      height: 1.42,
      overflow: TextOverflow.ellipsis);
  static const kTag = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.42,
  );
  static const kTagMini = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 10.5,
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.42,
  );
  static const kBodyStrong = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.42,
  );
  static const kBodyStrongWhite = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: OversightColors.white,
    height: 1.42,
  );
  static const kBodyHighlighted = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.5,
  );

  static const kButtonTitle = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.7,
    color: OversightColors.black,
    overflow: TextOverflow.ellipsis,
    height: 1.5,
  );
  static const kButtonTitleWhite = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.7,
    color: OversightColors.white,
    overflow: TextOverflow.ellipsis,
    height: 1.5,
  );
  static const kCaptionStrong = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.5,
  );
  static const kCaptionStrongWhite = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: OversightColors.white,
    height: 1.5,
  );
  static const kCaptionHighlighted = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.5,
  );
  static const kCaption = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.5,
  );
  static const kCaptionMini = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.25,
  );
  static const kCaptionMiniWhite = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: OversightColors.white,
    height: 1.25,
  );
  static const kCaptionMiniProduct = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: OversightColors.black,
    height: 1.25,
  );
  static const kCaptionSubtitle = TextStyle(
    fontFamily: 'Gilroy',
    fontSize: 12,
    fontWeight: FontWeight.w800,
    letterSpacing: 0,
    color: OversightColors.grey,
    height: 1.25,
  );
}
