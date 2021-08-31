
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:eat_more_app/helper/helper.dart';
import 'package:eat_more_app/helper/shared_preference.dart';
import 'package:eat_more_app/model/address_response.dart';
import 'package:eat_more_app/model/branch_response.dart';
import 'package:eat_more_app/model/cart_response.dart';
import 'package:eat_more_app/model/check_out_response.dart';
import 'package:eat_more_app/model/contact_response.dart';
import 'package:eat_more_app/model/faq_response.dart';
import 'package:eat_more_app/model/home_response.dart';
import 'package:eat_more_app/model/login_response.dart';
import 'package:eat_more_app/model/my_myfatoorah_response.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:eat_more_app/model/product_response.dart';
import 'package:eat_more_app/model/rajhi_response.dart';
import 'package:eat_more_app/model/setting_response.dart';
import 'package:eat_more_app/model/stauts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

 class RestaurantsApiModel extends Model{
  static final String url = "https://api.yalago.net/api/enterprise/eats/";
  RestaurantsApiModel() {
   if(UtilSharedPreferences.getObj('constant') != null)
    _getConstant();
    if (UtilSharedPreferences.getObj("user") != null){
      _currentUser=User.fromJson(UtilSharedPreferences.getObj("user"));
      notifyListeners();
    }
    if(UtilSharedPreferences.getInt('lang')==null){
      String language = Platform.localeName;
       print(language);
       if(language.startsWith('ar')){
         UtilSharedPreferences.setInt('lang', 1);
         _selectedLanguage=1;
         notifyListeners();

       }
       else{
         UtilSharedPreferences.setInt('lang', 0);
          _selectedLanguage=0;
          notifyListeners();
       }
      }
    else{
      if(UtilSharedPreferences.getInt('lang')==0){
        _selectedLanguage=0;
        notifyListeners();
      }
     else{
        _selectedLanguage=1;
        notifyListeners();
      }
    }
  }


  //user
  User _currentUser;
  void changeUser(User user){
    _currentUser=user;
    notifyListeners();
  }
  User get loggedUser => _currentUser;
  bool isLoggedIn() {
    return _currentUser != null;
  }

  //totalCart
  String _total="0.0";
  String get total => _total;
  void setTotal(String totalCart){
    print(totalCart);
    _total=totalCart;
    notifyListeners();
  }
  //address list
  final List<Addresses> _address = [];
  UnmodifiableListView<Addresses> get address => UnmodifiableListView(_address);
  void removeFromAddress(int index){
    _address.removeAt(index);
     notifyListeners();
  }
  void addAllToAddress(List<Addresses> address) {
    _address.clear();
    _address.addAll(address);
    notifyListeners();
  }

   //vendor_name and vendor_logo and vendor_id
  String _vendorName = "";
  String _vendorLogo = "";
  int _vendorId;
  String get name => _vendorName;
  String get logo => _vendorLogo;
  int get id => _vendorId;
  void setName(String vendorName){
    _vendorName=vendorName;
    notifyListeners();
  }
  void setLogo(String vendorLogo){
    _vendorLogo=vendorLogo;
    notifyListeners();
  }
  void setId(int vendorId){
    _vendorId=vendorId;
    notifyListeners();
  }
 //language
  int _selectedLanguage;
  int get language => _selectedLanguage;
  void change(int selectedLanguage) {
    _selectedLanguage = selectedLanguage;
    notifyListeners();
  }




  // header
  Map<String, String> headers() {
    return <String, String>{
      'language': language==0||UtilSharedPreferences.getInt('lang')==0?'en':'ar',
      'Authorization': UtilSharedPreferences.getString('token'),
    };
  }

  headers1(String token){
     headers().addAll({
      'token' : token
    });
  }
  //api
  Future<HomeResponse> listHome() {
    return http.get(
     Uri.parse(url + 'home') ,
      headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return HomeResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<ProductResponse> getProductInfo(int productId) {
    // print(productId);
    return http.get(
      Uri.parse(url + 'product-info?product_id=$productId') ,
      headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return ProductResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<BranchResponse> listBranch(int id,String longitude,String latitude,String type) {
    return http.get(
      Uri.parse(url + 'branches?vendor_id=$id&type=$type&longitude=$longitude&latitude=$latitude') ,
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return BranchResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<LoginResponse> loginUser(body,String subUrl){
    return http
        .post(
         Uri.parse(url + '$subUrl'),
        body: body,

    ).then((response){
      print(response.body);

      return LoginResponse.fromJson(json.decode(response.body));
    }
    );}
  Future<AddressResponse> getAddress() {
    return http.get(
        Uri.parse(url + 'auth/address') ,
        headers: headers()
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return AddressResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<AddressResponse> postAddress(body) {
    return http.post(
      Uri.parse(url + 'auth/address') ,
      headers: headers(),
      body: body
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return AddressResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<AddressResponse> deleteAddress(int idAddress) {
    return http.delete(
        Uri.parse(url + 'auth/address/$idAddress') ,
        headers: headers()
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return AddressResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<VendorResponse> viewVendorInfo(int vendorId) {
    return http.get(
        Uri.parse(url + 'info?vendor_id=$vendorId') ,
        headers: headers()
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return VendorResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<MenuResponse> viewMenuProduct(int idMenu) {
    return http.get(
        Uri.parse(url + 'menu/$idMenu') ,
        headers: headers()
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return MenuResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<CartResponse> addToCart(body) {
    return http.post(
        Uri.parse(url + 'auth/basket') ,
        body: body,
        headers: headers()
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return CartResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<CartResponse> getCart(int vendorId) {
    return http.get(
        Uri.parse(url + 'auth/basket?vendor_id=$vendorId') ,
        headers: headers()
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return CartResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<CartResponse> deleteCart(int cartId) {
    return http.delete(
        Uri.parse(url + 'auth/basket/$cartId') ,
        headers: headers()
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return CartResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<CartResponse> updateCart(int cartId,body) {
    return http.put(
        Uri.parse(url + 'auth/basket/$cartId') ,
        headers: headers(),
       body: body,
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return CartResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<CheckOutResponse> listPayment(int vendorId,body) {
    return http.post(
        Uri.parse(url + 'auth/orders/checkout?vendor_id=$vendorId'),
        headers: headers(),
        body: body,
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return CheckOutResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<MyFatoorahResponse> getMyFatoorah(int vendorId) {
    return http.get(
      Uri.parse(url + 'auth/payment/myfatoorah-auth?vendor_id=$vendorId') ,
      headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return MyFatoorahResponse.fromJson(json.decode(response.body));
    }
    );
  }

  Future<MyFatoorahPaymentResponse> paymentByMyFatoorah(int vendorId,body) {
   try{
     return http.post(
       Uri.parse(url + "auth/payment/myfatoorah-handler?vendor_id=$vendorId"),
       body:body,
       headers: headers(),
     ).then((response) {
       print(response.body);
       if (response.statusCode != 200) {
         print(response.reasonPhrase);
         print(response.body);
       }
       return MyFatoorahPaymentResponse.fromJson(json.decode(response.body));
     }
     );
   }
   catch(err){
     throw err;
   }
  }
  Future<OrderResponse> makeOrder(body) {
    return http.post(
      Uri.parse(url + "auth/orders/confirm-new-order"),
      body:body,
      headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return OrderResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<ProfileResponse> getProfileInfo(String subUrl,body) {
    return http.post(
      Uri.parse(url + subUrl),
      body: body,
      headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return ProfileResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<ProfileResponse> updateProfileInfo(String filePath,String fName,String lName,String gender,String email,String birthday) async {
    ProfileResponse profileResponse;
    var request= http.MultipartRequest(
        "POST",Uri.parse(url + 'auth/update'));
    request.headers.addAll(headers());
    if (filePath!=null)
      request.files.add(
        await http.MultipartFile.fromPath('avatar', filePath));
    request.fields["fname"]=fName;
    request.fields["lname"]=lName;
    request.fields["gender"]=gender;
    request.fields["email"]=email;
    request.fields["birthday"]=birthday;
    await request.send().then((result) async{
      await  http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200)
        {
          print('response.body '+response.body);
          profileResponse= ProfileResponse.fromJson(jsonDecode(response.body));
        }
        else
          print('response.body '+response.body);

      });
    }).catchError(
            (err) => print('error : '+err.toString()))
        .whenComplete(() {}
    );
    return profileResponse;
  }

  Future<AllOrderResponse> getAllOrder() {
    return http.get(
      Uri.parse(url+'auth/orders/my-all-orders'),
      headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return AllOrderResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<AllOrderResponse> contact(body) {
    return http.post(
      Uri.parse(url+'contact-us'),
      headers: headers(),
      body: body
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return AllOrderResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<ContactResponse> getSocialMediaLink() {
    return http.get(
        Uri.parse(url+'social-media-info'),
        headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return ContactResponse.fromJson(json.decode(response.body));
    }
    );
  }
  Future<FAQResponse> getFAQs() {
    return http.get(
      Uri.parse(url+'faq'),
      headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return FAQResponse.fromJson(json.decode(response.body));
    }
    );
  }

  Future <SettingResponse> listConstants() async {
    return http.get(
      Uri.parse( url + 'enterprise-settings'),
      headers: headers(),)
        .then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return SettingResponse.fromJson(jsonDecode(response.body));
    }
    );
  }
  Future <void> logout() async {
    return http.get(
      Uri.parse( url + 'auth/logout'),
      headers: headers(),)
        .then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return null;
    }
    );
  }
  Future <TrackOrderResponse> trackOrder(int orderId) async {
    return http.get(
      Uri.parse( url + 'auth/orders/tracking-order?order_id=$orderId'),
      headers: headers(),)
        .then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return TrackOrderResponse.fromJson(jsonDecode(response.body));
    }
    );
  }
  Future <CouponResponse> applyCoupon(int vendorId,body) async {
    return http.post(
      Uri.parse( url + 'auth/coupon/check?vendor_id=$vendorId'),
      headers: headers(),
      body: body
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return CouponResponse.fromJson(jsonDecode(response.body));
    }
    );
  }
  Future <RajhiResponse> getTokenRajhi() async {
    return http.get(
        Uri.parse( url + 'auth/payment/Rajhi-GenerateOAuth'),
        headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return RajhiResponse.fromJson(jsonDecode(response.body));
    }
    );
  }


  Future <RajhiPaymentResponse> paymentRajhi(String token,body) async {
    Map<String, String> headers1() {
      return <String, String>{
        'language': language==0||UtilSharedPreferences.getInt('lang')==0?'en':'ar',
        'Authorization': UtilSharedPreferences.getString('token'),
        "token":token
      };
    }
    print(token);
    print(headers1());
    return http.post(
      Uri.parse( url + 'auth/payment/Rajhi-checkMobile'),
      headers: headers1(),
      body: body
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return RajhiPaymentResponse.fromJson(jsonDecode(response.body));
    }
    );
  }
  Future <CheckOtpCodeResponse> checkOtpCode(String token,body) async {
    Map<String, String> headers1() {
      return <String, String>{
        'language': language==0||UtilSharedPreferences.getInt('lang')==0?'en':'ar',
        'Authorization': UtilSharedPreferences.getString('token'),
        "token":token
      };
    }
    return http.post(
        Uri.parse( url + 'auth/payment/Rajhi-checkOTPCode'),
        headers: headers1(),
        body: body
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return CheckOtpCodeResponse.fromJson(jsonDecode(response.body));
    }
    );
  }
  Future <void> updateFcmToken(body) async {
    return http.post(
      Uri.parse( url + 'auth/updateFcm_token'),
      headers: headers(),
      body: body
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return null;
    }
    );
  }
  Future <VendorCategoryResponse> getVendorCategory() async {
    return http.get(
        Uri.parse( url + 'vendor-category'),
        headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return VendorCategoryResponse.fromJson(jsonDecode(response.body));;
    }
    );
  }
  Future <AllVendorResponse> getVendors(int categoryId) async {
    return http.get(
      Uri.parse( url + 'vendor-Bycategory?vendorCategory_id=$categoryId'),
      headers: headers(),
    ).then((response) {
      print(response.body);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        print(response.body);
      }
      return AllVendorResponse.fromJson(jsonDecode(response.body));;
    }
    );
  }

  void _getConstant() async {
    await listConstants().then((value) {
      if(value.status.status){
       Setting setting= Setting.fromJson(UtilSharedPreferences.getObj('constant'));
       if(setting.gif!=value.data.gif)
         UtilSharedPreferences.setObj('constant',value.data);
      }
    });
  }
}