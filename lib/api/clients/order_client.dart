

import 'package:eat_more_app/model/order_response.dart';

import '../http_manager.dart';

class OrderClient{
  Future <String> makeOrder(body) async {
    try {
      final response = await HttpManager.post<Order>(
          'auth/orders/confirm-new-order',
          body,
              (json) => Order.fromJson(json),
      );
      return response?.order_number??"";
    } catch (err) {
      throw (err);
    }
  }
  // Future<List<Order>> listOrders(){
  //   try {
  //     final response = await HttpManager.get<Order>(
  //       'auth/orders/confirm-new-order',
  //       body,
  //           (json) => Order.fromJson(json),
  //     );
  //     return response?.order_number??"";
  //   } catch (err) {
  //     throw (err);
  //   }
  // }

}
