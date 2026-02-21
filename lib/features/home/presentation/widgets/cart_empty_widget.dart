import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 72.sp, color: AppColors.border),
          SizedBox(height: 16.h),
          Text('Your cart is empty', style: AppStyles.heading2),
          SizedBox(height: 8.h),
          Text('Add items to get started', style: AppStyles.muted),
        ],
      ),
    );
  }
}

