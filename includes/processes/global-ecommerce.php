<?php
global $CONFIG, $SMARTY, $DBobject, $GA_ID, $REQUEST_URI;

// Redirect to login page when displaying members only page and user is not logged in
$loginUrl = '/login-register';
if(!empty($SMARTY->getTemplateVars('listing_membersonly')) && $REQUEST_URI != $loginUrl && empty($_SESSION['user']['public']['id'])){
  header('Location: ' . $loginUrl);
  die();
}

// Load shopping cart details
try{
  $cart_obj = new cart($_SESSION['user']['public']['id']);
  $cart = $cart_obj->GetDataCart();
  $SMARTY->assign('cart', $cart);
  $itemNumber = $cart_obj->NumberOfProductsOnCart();
  $SMARTY->assign('itemNumber', $itemNumber);
  $subtotal = $cart_obj->GetSubtotal();
  $SMARTY->assign('subtotal', $subtotal);
  $productsOnCart = $cart_obj->GetDataProductsOnCart();
  $SMARTY->assign('productsOnCart', $productsOnCart);
  
  //Shipping
  $discountData = $cart_obj->GetDiscountData($cart['cart_discount_code']);
  $shippable = $cart_obj->ShippableCartitems();
  $SMARTY->assign('shippable', $shippable);
  $shipping_obj = new ShippingClass(count($shippable), $discountData['discount_shipping']);
  $SMARTY->assign('shippingMethods', $shipping_obj->getShippingMethods());
}
catch(exceptionCart $e){
  $SMARTY->assign('error', $e->getMessage());
}

  
