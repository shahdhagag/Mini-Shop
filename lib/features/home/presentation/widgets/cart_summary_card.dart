import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class CartSummaryCard extends StatelessWidget {
  final double totalPrice;

  const CartSummaryCard({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          SummaryRow(
            label: 'Items Total',
            value: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'EGP ', style: AppStyles.body),
                  TextSpan(
                    text: totalPrice.toStringAsFixed(0),
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mainText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SummaryRow(
            label: 'Shipping Fee',
            value: Text(
              'Free',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ),
          Gap(12.h),
          SummaryRow(
            label: 'Total',
            value: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'EGP ', style: AppStyles.body),
                  TextSpan(
                    text: totalPrice.toStringAsFixed(0),
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final Widget value;

  const SummaryRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppStyles.labelMuted),
        value,
      ],
    );
  }
}

