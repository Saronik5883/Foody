import 'dart:core';

import 'package:flutter/material.dart';
import 'package:foodapp/data/repository/popular_products_repo.dart';
import 'package:foodapp/utils/AppColors.dart';
import 'package:get/get.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList => _popularProductList;
  List dummyList=[];
  late CartController _cart;
  // CartController _cart = CartController(cartRepo: cartRepo);


  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity=0;
  int get quantity=>_quantity;

  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      // print("Got products");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList.length);
      _isLoaded=true;
      update();
    }else{

    }
  }

  Future<void> getDummyList() async{
    Response response = await popularProductRepo.getPopularProductList();
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
      print("number of items "+quantity.toString());
    }
    else{
      _quantity = checkQuantity(_quantity-1);
      print("decrement $_quantity");
    }
    update();
  }


  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Item count", "You can't reduce more!", );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity)>20){
      Get.snackbar("Item count", "You can't add more!",);
      return 20;
    }
    else{
      return quantity;
    }
  }

  void initDummy(CartController cart){
    _cart=cart;
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart=cart;
    
    var exist=false;
    exist = _cart.existInCart(product);
    //if exist
    //get from storage _inCartItems =
    //print("exist or not :"+exist.toString());
    if(exist){
      _inCartItems = cart.getQuantity(product);
    }
    //print("The quantity in the cart is "+_inCartItems.toString());

  }

  void addItem(ProductModel product){
    if (_cart != null) {
      _cart.addItem(product, _quantity);

      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);

      _cart.items.forEach((key, value) {
        print("The id is ${value.id} The quantity is: ${value.quantity}");
      });

      update();
    }
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }


}