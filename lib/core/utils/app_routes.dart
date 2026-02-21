import 'package:exam/features/home/presentation/screens/cart_screen.dart';
import 'package:exam/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouts {


  static const String homeScreen = '/';
  static const String cartScreen = '/cartScreen';

  static final GoRouter router = GoRouter(
    initialLocation: homeScreen,
    routes: [
      GoRoute(
        path: homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: cartScreen,
        builder: (context, state) => const CartScreen(),
      ),
    ],
  );
}