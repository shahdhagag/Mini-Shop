import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/model/cart_item.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_badge_icon.dart';
import '../widgets/cart_empty_widget.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_summary_card.dart';
import '../widgets/checkout_btn.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: AppBar(
        backgroundColor: AppColors.backGround,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.main,
            size: 20.sp,
          ),
        ),
        title: Text('My Cart', style: AppStyles.appBarTitle),
        centerTitle: true,
        actions: [
          const CartBadgeIcon(),
          SizedBox(width: 20.w),
        ],
      ),
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, items) {
          if (items.isEmpty) {
            return const CartEmptyWidget();
          }

          final totalPrice = context.read<CartCubit>().totalPrice;

          return Column(
            children: [
              CartSummaryCard(totalPrice: totalPrice),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${items.length} Items', style: AppStyles.label),
                ),
              ),
              Gap(8.h),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: items.length,
                  itemBuilder: (context, index) =>
                      CartItemCard(item: items[index]),
                ),
              ),
              const CheckOutButton(),
            ],
          );
        },
      ),
    );
  }
}

