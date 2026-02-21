import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  AppStyles._();

  static TextStyle get heading1 => GoogleFonts.inter(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mainText,
      );

  static TextStyle get heading2 => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mainText,
      );
  static TextStyle get heading3 => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.sec,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.mainText,
      );

  static TextStyle get muted => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.muted,
      );
  static TextStyle get muted2 => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.muted,
      );

  static TextStyle get price => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.mainText,
      );

  static TextStyle get priceCart => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mainText,
      );

  static TextStyle get label => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.mainText,
      );

  static TextStyle get labelMuted => GoogleFonts.poppins(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.muted,
      );

  static TextStyle get link => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.main,
      );

  static TextStyle get appBarTitle => GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mainText,
      );

  static TextStyle get buttonText => GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );
}

