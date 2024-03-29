import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lab_store/data_layer/models/product_model.dart';
import 'package:lab_store/presentation_layer/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/route_manager/app_routes.dart';
import '../../../../core/style/color_manager.dart';
import '../../../provider/cart_provider.dart';

class SaleItemBuilder extends StatelessWidget {
  const SaleItemBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productModel = Provider.of<ProductModel>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    bool isInCart = cartProvider.getCartItems.containsKey(productModel.id);

    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    bool isInFav =
        favoriteProvider.getFavoriteItems.containsKey(productModel.id);

    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          AppRoutes.productDetailsScreenRoute,
          arguments: productModel,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                SizedBox(
                  width: 145,
                  height: 170,
                  child: Image(
                    image: AssetImage(productModel.imageUrl),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                        child: Text(
                      'on Sale',
                    )),
                  ),
                ),
                Positioned(
                  left: size.width * 0.23,
                  bottom: size.height * 0.011,
                  child: InkWell(
                    onTap: () {
                      if (isInFav) {
                        favoriteProvider.removeOneItem(
                            productId: productModel.id);
                      } else {
                        favoriteProvider.addProductToFavorite(
                            productId: productModel.id);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.5)),
                        child: Icon(
                          isInFav ? IconlyBold.heart : IconlyLight.heart,
                          size: 30,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: size.width * 0.12,
                  bottom: size.height * 0.01,
                  child: InkWell(
                    onTap: () {
                      if (isInCart) {
                        cartProvider.removeOneItem(productId: productModel.id);
                      } else {
                        cartProvider.addProductToCart(
                            productId: productModel.id);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.5)),
                        child: Icon(
                          isInCart ? IconlyBold.buy : IconlyLight.buy,
                          size: 30,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            RatingBarIndicator(
              itemSize: 25.0,
              //  rating: dummyProduct.rate?.toDouble() ?? 4.0,
              rating: productModel.rate!.toDouble(),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              direction: Axis.horizontal,
            ),
            const SizedBox(
              height: 3,
            ),
            SizedBox(
              width: 145,
              child: Text(
                productModel.title,
                style: const TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              productModel.productCategoryName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            if (productModel.isDiscount!)
              Row(
                children: [
                  Text('${productModel.price}\$',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${productModel.salePrice}\$',
                    style: TextStyle(color: ColorManager.primary),
                  ),
                ],
              ),
            if (!productModel.isDiscount!)
              Text(
                '${productModel.salePrice}\$',
                style: TextStyle(color: ColorManager.primary),
              ),
          ],
        ),
      ),
    );
  }
}
