import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(HomeInitial());

  final HomeRepo repo;

  Future<void> getProducts() async {
    emit(HomeLoading());
    try {
      final products = await repo.getProducts();
      emit(HomeSuccess(products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
