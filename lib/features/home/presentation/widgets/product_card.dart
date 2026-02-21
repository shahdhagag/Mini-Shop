import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/model/product_model.dart';
import '../cubit/cart_cubit.dart';

class ProductCard extends StatelessWidget {
  final Products product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List>(
      builder: (context, cartItems) {
        final cart = context.read<CartCubit>();
        final inCart = cart.isInCart(product.id ?? -1);
        final qty = cart.quantityOf(product.id ?? -1);

        return Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: Container(
                    color: AppColors.productBg,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail ?? '',
                      fit: BoxFit.contain,
                      placeholder: (_, __) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (_, __, ___) =>
                          const Icon(Icons.broken_image_outlined),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      product.title ?? '',
                      style: AppStyles.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    Gap(4.h),



                    // Rating
                    Row(
                      children: [
                        Icon(Icons.star_rounded,
                            color: AppColors.Rating, size: 16.sp),
                        SizedBox(width: 2.w),
                        Text(
                          '${product.rating?.toStringAsFixed(1)} (${product.stock} reviews)',
                          style: AppStyles.muted,
                        ),
                      ],
                    ),
                    Gap( 6.h),

                    // Price + Cart button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price?.toStringAsFixed(0)}',
                          style: AppStyles.price,
                        ),
                        if (!inCart)
                          GestureDetector(
                            onTap: () {
                              cart.addToCart(product);
                              _showAddedToCartSheet(context, product);
                            },
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: AppColors.cardBg,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: AppColors.stork,
                                  width: 1,
                                ),
                              ),
                              child:Image.asset(
                                AppAssets.shoppingBasketAdd,
                                width: 19.w,
                                height: 19.h,
                                // color: AppColors.main,
                              ),
                            ),
                          )
                        else
                          _QuantityController(
                            quantity: qty,
                            onIncrement: () =>
                                cart.increment(product.id ?? -1),
                            onDecrement: () =>
                                cart.decrement(product.id ?? -1),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddedToCartSheet(BuildContext context, Products product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => _AddedToCartSheet(product: product),
    );
  }
}

class _QuantityController extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QuantityController({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleBtn(
          icon: Icons.remove,
          onTap: onDecrement,
          outlined: true,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Text(
            '$quantity',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _CircleBtn(
          icon: Icons.add,
          onTap: onIncrement,
          outlined: false,
        ),
      ],
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool outlined;

  const _CircleBtn(
      {required this.icon, required this.onTap, required this.outlined}
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          color: outlined ? AppColors.productBg : AppColors.main,
          borderRadius: BorderRadius.circular(6.r),
          border: outlined
              ? Border.all(color: AppColors.stork, width: 1.5)
              : null,
        ),
        child: Icon(
          icon,
          size: 14.sp,
          color: outlined ? AppColors.sec : Colors.white,
        ),
      ),
    );
  }
}

class _AddedToCartSheet extends StatelessWidget {
  final Products product;

  const _AddedToCartSheet({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.title ?? '', style: AppStyles.heading2),
          Gap(4.h),
          Row(
            children: [
              Text('Added to cart', style: AppStyles.muted2),
              Gap(7.w),
              Icon(Icons.check_circle_rounded,
                  color: Colors.green, size: 20.sp),
            ],
          ),
          Gap(20.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.push(AppRouts.cartScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.main,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text('View Cart', style: AppStyles.buttonText),
            ),
          ),
          Gap( 12.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.main, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text('Continue Shopping', style: AppStyles.link),
            ),
          ),
        ],
      ),
    );
  }
}



