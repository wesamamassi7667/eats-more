
import 'clients/cart_client.dart';
import 'clients/check_out_client.dart';
import 'clients/configure_client.dart';
import 'clients/order_client.dart';
import 'clients/service_client.dart';

class AppApi {
  static CheckOutClient checkOutClient = CheckOutClient();
  static ServiceClient serviceClient = ServiceClient();
  static CartClient cartClient = CartClient();
  static OrderClient orderClient = OrderClient();
  static ConfigureClient configureClient = ConfigureClient();
}
