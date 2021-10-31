
import 'package:eat_more_app/model/cart_response.dart';

import '../http_manager.dart';

class CartClient{
  Future<Cart> listCart(int vendorId) async {
    try{
      final response=await  HttpManager.get<Cart>('auth/basket?vendor_id=$vendorId',(json) => Cart.fromJson(json));
      return response;
    }
    catch(err){
      throw(err);
    }
  }

  Future<void> addCart(body) async {
    try{
      final response=await  HttpManager.post<void>('auth/basket',body,(json){});
      return response;
    }
    catch(err){
      throw(err);
    }
  }
  Future<void> deleteCart(int cartId) async {
    try{
     await  HttpManager.delete<void>('auth/basket/$cartId',(json){});
    }
    catch(err){
      throw(err);
    }
  }

  Future<void> updateCart(int cartId,body) async {
    try{
      await  HttpManager.put<void>('auth/basket/$cartId',body,(json){});
    }
    catch(err){
      throw(err);
    }
  }


}