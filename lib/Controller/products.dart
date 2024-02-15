import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Constant/app_constant.dart';
import '../Model/all_products.dart';
import '../View/Component/AppWidgets/snack_bar.dart';

class ProductsController extends ChangeNotifier {
  List<AllProducts> allProducts = [];
  List<AllProducts> cartProducts = [];
  bool isLoaded = false;

  ///////fetchAllProducts
  Future getAllProducts() async {
    isLoaded = false;
    try {
      http.Response response = await http.get(Uri.parse(AppConstant.baseUrl));
      if (response.statusCode == 200) {
        allProducts = allProductsFromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    isLoaded = true;
    notifyListeners();
  }

  ///////addProductsToCart
  void addProductsToCart(AllProducts allProducts, context) {
    if (cartProducts
        .where((element) => element.id == allProducts.id)
        .isNotEmpty) {
      allProducts.quantity++;
    } else {
      cartProducts.add(allProducts);
    }
    SnackBarWidget.showSnackBarWidget(
      context,
      'Added To Cart Successfully!',
      Colors.green[400]!,
    );
    notifyListeners();
  }

  ///////deleteProductsFromCart
  void deleteProductsFromCart(AllProducts allProducts, context) {
    cartProducts.remove(allProducts);
    SnackBarWidget.showSnackBarWidget(
      context,
      'Deleted From Cart Successfully!',
      Colors.red[200]!,
    );
    notifyListeners();
  }

  double getTotalPrice() {
    double totalPrices = 0.0;
    for (int i = 0; i < cartProducts.length; i++) {
      totalPrices +=
          cartProducts[i].quantity * double.parse(cartProducts[i].price);
    }

    return double.parse(totalPrices.toStringAsFixed(2));
  }

  void canIncrease(index) {
    if (cartProducts[index].quantity < 9) {
      cartProducts[index].quantity++;
    }
    notifyListeners();
  }

  void canDecrease(index) {
    if (cartProducts[index].quantity == 1) {
      cartProducts.removeAt(index);
    } else {
      if (cartProducts[index].quantity > 0) {
        cartProducts[index].quantity--;
      }
    }

    notifyListeners();
  }
}
