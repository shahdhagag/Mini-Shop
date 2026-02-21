import 'package:exam/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/repo/home_repo.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/cart_badge_icon.dart';
import '../widgets/home_error_widget.dart';
import '../widgets/products_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(HomeRepo())..getProducts(),
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: AppBar(
          backgroundColor: AppColors.backGround,
          elevation: 0,
          title: Image.asset(
            AppAssets.appLogo,
            height: 42.h,
            width: 100.w,
            fit: BoxFit.contain,
          ),
          actions: [
            const CartBadgeIcon(),
            Gap(20.w),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return HomeErrorWidget(message: state.message);
            } else if (state is HomeSuccess) {
              return ProductsGrid(products: state.products);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
