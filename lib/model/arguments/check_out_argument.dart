
import 'package:eat_more_app/model/cart_response.dart';

import '../branch_response.dart';

class CheckOutArgument{
  int id;
  Branch branch;
  double deliveryCost;
  int idWay;
  int vat;
  String time;
  List<ProductCart> carts;
  double total;
  String address;
  double minimum;
  String lat;
  String lng;
  String vatNo;

  CheckOutArgument(
      this.id,
      this.branch,
      this.deliveryCost,
      this.idWay,
      this.vat,
      this.time,
      this.carts,
      this.total,
      this.address,
      this.minimum,
      this.lat,
      this.lng,
      this.vatNo
      );
}