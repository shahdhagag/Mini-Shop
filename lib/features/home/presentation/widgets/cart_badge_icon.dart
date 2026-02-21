import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/model/cart_item.dart';
import '../cubit/cart_cubit.dart';

class CartBadgeIcon extends StatelessWidget {
  const CartBadgeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<CartItem>>(
      builder: (context, items) {
        final count = context.read<CartCubit>().totalItems;
        return GestureDetector(
          onTap:(){
            /// Get the current location path///
            final String currentLocation = GoRouterState.of(context).uri.path;

            if (currentLocation != '/cartScreen') {
              context.push('/cartScreen');
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                AppAssets.shoppingBasket,
                width: 26.w,
                height: 26.h,
              ),

              if (count > 0)
                Positioned(
                  left: -6,
                  child: Container(
                    width: 17.w,
                    height: 17.h,
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$count',
                        style: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}



