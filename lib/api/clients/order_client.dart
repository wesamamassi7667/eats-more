


import 'package:eat_more_app/model/api_result_model.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../http_manager.dart';
import '../map_api.dart';

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
    try {
    final  response = await HttpManager.get<dynamic>(
        'auth/orders/my-all-orders',
            (json) {
              return (json as List)
                    ?.map(
                        (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
                    ?.toList();
            } ,
      );
    return response??[];
    }
    catch (err) {
      throw (err);
    }
  }

  Future <TrackOrder> trackOrder(int orderId) async {
    try {
      final response = await HttpManager.get<TrackOrder>(
        'auth/orders/tracking-order?order_id=$orderId',
            (json) => TrackOrder.fromJson(json),
      );
      return response;
    } catch (err) {
      throw (err);
    }
  }

  // Future<APIResultModel> getRouteCoordinates(LatLng l1, LatLng l2) {
  //   return API.getRouteCoordinates({
  //     'origin': '${l1.latitude},${l1.longitude}',
  //     'destination': '${l2.latitude},${l2.longitude}',
  //     'key': Application.GOOGLE_MAPS_API_KEY,
  //   });
  // }

}
