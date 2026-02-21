import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/home_cubit.dart';

class HomeErrorWidget extends StatelessWidget {
  final String message;

  const HomeErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded, color: AppColors.red, size: 48.sp),
          SizedBox(height: 12.h),
          Text(message, style: AppStyles.muted, textAlign: TextAlign.center),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => context.read<HomeCubit>().getProducts(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

