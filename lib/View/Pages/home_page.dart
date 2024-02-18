import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/products.dart';
import '../Component/AppWidgets/app_search_form.dart';
import '../Component/AppWidgets/app_text.dart';
import '../Component/Widgets/products_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductsController>(context, listen: false).getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<ProductsController>(
    //   context,
    // );
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Icon(
                Icons.menu,
                color: Colors.grey[700],
              ),
              const SizedBox(
                height: 20,
              ),
              const AppSearchForm(),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: AppText(
                  text: 'everyone files... some fly longer than others',
                  textAlign: TextAlign.center,
                  color: Colors.grey[600]!,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const AppText(
                text: 'All Products',
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              Consumer<ProductsController>(
                  builder: (context, productsController, child) => Visibility(
                        visible: productsController.isLoaded,
                        replacement: const Padding(
                          padding: EdgeInsets.only(top: 150),
                          child: Center(
                            child: CupertinoActivityIndicator(
                              radius: 12,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ...List.generate(
                                productsController.allProducts.length,
                                (index) => SingleChildScrollView(
                                      child: ProductsWidget(
                                          price: productsController
                                              .allProducts[index].price,
                                          title: productsController
                                              .allProducts[index].title,
                                          image: productsController
                                              .allProducts[index].image,
                                          onAdd: () {
                                            productsController
                                                .addProductsToCart(
                                                    productsController
                                                        .allProducts[index],
                                                    context);
                                          }),
                                    ))
                          ],
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
