import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:get/get.dart';

class BreakfastRepo extends GetxService{
  final ApiClient apiCLient;
  BreakfastRepo({required this.apiCLient});

  Future<Response> getBreakfastList() async{
    return await apiCLient.getData(AppConstants.BREAKFAST_URI);
  }
}