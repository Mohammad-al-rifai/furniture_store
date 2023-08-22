import 'package:ecommerce/presentation/resources/constants_manager.dart';

class Urls {
  static String baseUrl = 'http://${Constants.serverIP}:3000';

  static String filesUrl = '$baseUrl/api/download?fileName=';

  // *************** Start Auth Feature **************
  static const String login = '/user/Customer/auth';
  static const String register = '/user/Customer/SignUp';
  static const String forgetPassword = '/user/Customer/updatePassword';
  static const String mailVerify = '/user/sendCodeToCustomerEmail';
  static const String getProfile = '/user/Customer/getProfile';
  static const String logout = '/user/allUsers/logout';

  // *************** Start Home Layout Feature **************
  static const String banners = '/user/allUser/getBanners';
  static const String getHotSelling = '/user/allUsers/getHotSelling';
  static const String getCategories = '/user/allUsers/getCategorie/';
  static const String getAllMerchants = '/user/allUsers/getAllMerchants/';

  // *************** Start One Merchant Feature **************
  static const String getMerchantProducts = '/user/allUsers/MerchantProducts/';
  static const String getSinglePro = '/user/allUsers/Product/';
  static const String getGalleryProduct = '/user/allUsers/GalleryProduct/';
  static const String getVideo4Product = '/user/allUsers/getProduct/';
  static const String getVRModel4Product = '/user/allUsers/getProduct/';
  static const String getMerchantOffers = '/user/allUsers/getProduct/';
  static const String getMerchantProsByCat =
      '/user/allUsers/CategorieProducts/';

// *************** Start Cart Management Feature **************

  static const String add2Cart = '/user/Customer/addToCart';
  static const String getUserCart = '/user/Customer/getUserCart';
  static const String deleteProFromCart =
      '/user/Customer/deleteProductFromCart';
  static const String operationsOnCart = '/user/Customer/decrementItemOnCart';

// *************** Start Order Management Feature **************
  static const String addOrder = '/user/Customer/addOrder';
  static const String getUserOrders = '/user/allUsers/getUserOrders';
  static const String getOrderById = '/user/allUsers/getOrderById/';
  static const String cancelOrder = '/user/allUsers/ChangeOrderStatus';
  static const String orderAdvancedSearch = '/user/allUsers/advancedSearch/';
  static const String getMyBalance = '/user/allUsers/getMyBalance';
  static const String getOrderHistory =
      '/user/allUsers/getUserProductsHistory/';
  static const String getUserPointsHistory =
      '/user/allUsers/getUserPointsHistory';

// *************** Start Wishlist Management Feature **************
  static const String add2WishList = '/user/Customer/addToWishList';
  static const String getMyWishlist = '/user/Customer/getWishListByUserID';
  static const String removeProFromWishlist = '/user/Customer/removeToWishList';
  static const String deleteMyWishlist =
      '/user/Customer/deleteWishListByUserID';

// *************** Start Recommendation System Feature **************
  static const String recSysML = '/user/allUsers/recommendations';

// *************** Start Payment Feature **************
  static const String pay = '/user/Customer/pay';

  // *************** Start Features Feature **************
  static const String getFeatures = '/user/Customer/getAllFeature';
}
