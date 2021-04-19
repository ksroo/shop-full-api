import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_udemy/model/categries_model.dart';
import 'package:shop_udemy/model/home_model.dart';
import 'package:shop_udemy/screens/shopLayoyt/cubit/cubit.dart';
import 'package:shop_udemy/screens/shopLayoyt/cubit/states.dart';
import 'package:shop_udemy/shared/style/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categriesModel != null,
          builder: (context) => productsBuilder(
              ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categriesModel,
              context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, CategriesModel categriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: categriesModel.data.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "New Products",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[200],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.48,
                children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Container(
        height: 100,
        width: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(.8),
              width: double.infinity,
              child: Text(
                model.name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.purple,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${model.price}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          "${model.oldPrice}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            ShopCubit.get(context).favorites[model.id]
                                ? defaultColor
                                : Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                            print(model.id);
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
