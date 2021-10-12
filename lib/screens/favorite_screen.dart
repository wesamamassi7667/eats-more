import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/component/app_dialog.dart';
import 'package:eat_more_app/component/my_progress_indicator.dart';
import 'package:eat_more_app/component/second_header_component.dart';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/model/dynamic_response.dart';
import 'package:eat_more_app/model/favorite_response.dart';
import 'package:eat_more_app/widgets/empty_widget_column.dart';
import 'package:eat_more_app/widgets/favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
                _favorites[index], index),
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
    FavoriteResponse response =
        await ScopedModel.of<RestaurantsApiModel>(context).getFavorite();
    if (response.status.status)
      _favorites.addAll(response.data?.favorite ?? []);
    setState(() => _isLoading = false);
  }

  _buildFavoriteItem(Favorite favorite, index) {
    return FavoriteItem(
      press: () => _deleteFavoriteItem(favorite.member_meal_favorite, index),
      product: favorite.product,
    );
  }

  _deleteFavoriteItem(int favoriteId, index) async {
    Helper.showSingleAnimationDialog(context);
    DynamicResponse response =
        await ScopedModel.of<RestaurantsApiModel>(context)
            .deleteFavorite(favoriteId);
    if (response.status.status) {
      setState(() => _favorites.removeAt(index));
    } else {
      AppDialog.showMe(context, response.status.HTTP_response);
    }
    Navigator.pop(context);
  }
}
