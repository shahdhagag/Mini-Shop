import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/model/cart_item.dart';
import '../cubit/cart_cubit.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartCubit>();
    final product = item.product;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          /// Image
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: AppColors.productBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail ?? '',
                fit: BoxFit.contain,
                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.broken_image_outlined),
              ),
            ),
          ),
          Gap( 12.w),

          /// deatils
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.brand ?? product.title ?? '',
                  style: AppStyles.heading2,
                ),
                Gap( 2.h),
                Text(
                  product.title ?? '',
                  style: AppStyles.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap( 6.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'EGP ',
                        style: AppStyles.body,
                      ),
                      TextSpan(
                        text: product.price?.toStringAsFixed(0) ?? '0',
                        style: AppStyles.priceCart,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// delete + quantity
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: AppColors.stork),
                ),
                child: GestureDetector(
                  onTap: () => cart.removeFromCart(product.id ??0),
                  child:  Image.asset(
                      AppAssets.deleteIcon,
                      width: 24,
                      height: 24,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              _QuantityRow(
                quantity: item.quantity,
                onDecrement: () => cart.decrement(product.id ?? 0),
                onIncrement: () => cart.increment(product.id ?? 0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




class _QuantityRow extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _QuantityRow({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.stork),
      ),
      child: Row(
        children: [
          _QBtn(
            icon: Icons.remove,
            onTap: onDecrement,
            outlined: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              '$quantity',
              style: AppStyles.label,
            ),
          ),
          _QBtn(
            icon: Icons.add,
            onTap: onIncrement,
            outlined: false,
          ),
        ],
      ),
    );
  }
}

class _QBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool outlined;

  const _QBtn({required this.icon, required this.onTap, required this.outlined});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w,
        height: 28.h,
        decoration: BoxDecoration(
          color: outlined ? AppColors.productBg : AppColors.main,
          borderRadius: BorderRadius.circular(8.r),
          border: outlined
              ? Border.all(color: AppColors.stork, width: 1.5)
              : null,
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: outlined ? AppColors.mainText : Colors.white,
        ),
      ),
    );
  }
}

