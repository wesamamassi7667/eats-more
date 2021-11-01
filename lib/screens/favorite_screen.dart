import 'package:eat_more_app/api/app_api.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/common/common.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/second_header_component.dart';

import 'package:eat_more_app/model/favorite_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/widgets/empty_widget_column.dart';
import 'package:eat_more_app/widgets/favourite_item.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  final String title;
  const FavoriteScreen({Key key, this.title}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Favorite> _favorites;
  var _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    _favorites = [];
    super.initState();
    _getFavoriteProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SecondHeaderComponent(
      title: widget.title,
      child:_isLoading?MyProgressIndicator():
      _favorites.isEmpty? EmptyWidgetColumn(
        message: 'no_item_wish_list',
        icon: Icons.favorite,
      ):Padding(
        padding: const EdgeInsets.only(top: 25),
        child: ListView.separated(
            itemBuilder: (_, index) => _buildFavoriteItem(
                _favorites[index].product, index),
            separatorBuilder: (context, index) => Divider(
              color: grey4.withOpacity(0.11),
              thickness: 1,
            ),
            itemCount: _favorites.length),
      ),
    );
  }

  void _getFavoriteProduct() async {
    setState(() => _isLoading = true);
    final response =
        await AppApi.favouriteClient.listFavourite();
      _favorites.addAll(response);
    setState(() => _isLoading = false);
  }

  _buildFavoriteItem(ProductInfo product, index) {
    return FavoriteItem(
      press: () => _deleteFavoriteItem(product.product_id, index),
      product: product,
    );
  }

  _deleteFavoriteItem(int productId, index) async {
    try{
       Common.showSingleAnimationDialog(context);
       await AppApi.favouriteClient.deleteFavourite(productId);
       Navigator.pop(context);
       setState(() => _favorites.removeAt(index));
    }
    catch(err){
      Common.showError(err, context);
    }
  }
}
