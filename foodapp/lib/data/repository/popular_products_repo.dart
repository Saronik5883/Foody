import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiCLient;
  PopularProductRepo({required this.apiCLient});

  Future<Response> getPopularProductList() async{
    return await apiCLient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}