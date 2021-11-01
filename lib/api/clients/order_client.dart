

import 'dart:convert';

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

  Future <List<Order>> listOrders() async {
    // try {
    final  response = await HttpManager.get<List<Order>>(
        'auth/orders/my-all-orders',
            (json) {
              return (json as List)
                  ?.map(
                      (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
                  ?.toList();
            } ,
      );





      return response??[];
    // }
    // catch (err) {
    //   throw (err);
    // }
  }

}
