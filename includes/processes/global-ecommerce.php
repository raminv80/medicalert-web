<?php
global $CONFIG, $SMARTY, $DBobject, $GA_ID, $REQUEST_URI;

// **************** REDIRECT SECTION
$loginUrl = '/login';
$loginRegisterUrl = '/login-register';
$checkoutUrl = '/checkout';
$membersAreaUrl = '/my-account';

$redirect = empty($_SESSION['redirect']) ? (empty($_SESSION['post']['redirect']) ? $_SERVER['HTTP_REFERER'] : $_SESSION['post']['redirect']) : $_SESSION['redirect'];
$SMARTY->assign('redirect', $redirect);
$_SESSION['redirect'] = null;

// Redirect to login page when displaying members only page and user is not logged in
if(((!empty($SMARTY->getTemplateVars('listing_membersonly')) || !empty($SMARTY->getTemplateVars('product_membersonly'))) && $REQUEST_URI != $loginUrl && empty($_SESSION['user']['public']['id']))
    || ($REQUEST_URI == $checkoutUrl && empty($_SESSION['user']['public']['id']) && empty($_SESSION['user']['new_user']))
  ){
  $_SESSION['redirect'] = $REQUEST_URI;
  header('Location: ' . (($REQUEST_URI == $checkoutUrl)? $loginRegisterUrl : $loginUrl));
  die();
}

//Redirect to member's area when logged in
if(($REQUEST_URI == $loginUrl || $REQUEST_URI == $loginRegisterUrl) && !empty($_SESSION['user']['public']['id'])){
  header('Location: ' . $membersAreaUrl);
  die();
}



//MAF ONLY - set BUPA discount code
if(!empty($_REQUEST['setdc'])){
  $_SESSION['reApplydiscount'] = $_REQUEST['setdc'];
}

// **************** LOAD ECOMMERCE DETAILS
try{
  $cart_obj = new cart($_SESSION['user']['public']['id']);
  $cart = $cart_obj->GetDataCart();
  $SMARTY->assign('cart', $cart);
  $itemNumber = $cart_obj->NumberOfProductsOnCart();
  $SMARTY->assign('itemNumber', $itemNumber);
  $discount = $cart_obj->GetDiscountData($cart['cart_discount_code']);
  $SMARTY->assign('discount', $discount);
  $subtotal = $cart_obj->GetSubtotal();
  $SMARTY->assign('subtotal', $subtotal);
  $productsOnCart = $cart_obj->GetDataProductsOnCart();
  $SMARTY->assign('productsOnCart', $productsOnCart);
  
  //Wish list
  $wishlist = $cart_obj->GetWishList();
  $SMARTY->assign('wishlist', $wishlist);
  
  //Temporary user's addresses
  $SMARTY->assign('address', $_SESSION['address']);
  
  $SMARTY->assign('orderNumber', $_SESSION['orderNumber']);
  $SMARTY->assign('conversionTracking', $_SESSION['conversionTracking']);// ASSIGN JS-SCRIPTS TO GOOGLE ANALYTICS - ECOMMERCE (USED ON THANK YOU PAGE)
  unset($_SESSION['conversionTracking']);
  
  if(!empty($GA_ID) && $REQUEST_URI == $loginRegisterUrl){
    $productsGA = $cart_obj->getCartitemsByCartId_GA();
    sendGAEnEcCheckoutStep($GA_ID, '2', 'Login / Join', $productsGA);
  }
}
catch(exceptionCart $e){
  $SMARTY->assign('error', $e->getMessage());
}


//MAF ONLY - auto apply SENIORS when DOB >= 60 years and seniors card not empty
if($itemNumber > 0 && empty($cart['cart_discount_code']) && empty($_SESSION['reApplydiscount'])){ 
  $dob = '';
  $seniorsCard = '';
  $age = 0;
  
  //New member
  if(!empty($_SESSION['user']['new_user']) && empty($_SESSION['user']['public']['id'])){
    if(isset($_SESSION['user']['new_user']['db_dob'])) $dob = $_SESSION['user']['new_user']['db_dob'];
      if(isset($_SESSION['user']['new_user']['seniorscard'])) $seniorsCard = $_SESSION['user']['new_user']['seniorscard'];
  }
  
  //Existing member - approved details
  if(!empty($_SESSION['user']['public']['maf']['update'])){
    $dob = $_SESSION['user']['public']['maf']['update']['user_dob'];
    $seniorsCard = $_SESSION['user']['public']['maf']['update']['attributes'][18];
  }
  
  //Existing member - pending details
  if(!empty($_SESSION['user']['public']['maf']['pending'])){
    $dob = $_SESSION['user']['public']['maf']['pending']['user_dob'];
    $seniorsCard = $_SESSION['user']['public']['maf']['pending']['attributes'][18];
  }
  
  if(!empty($dob)){
    //Calculate date difference between renewal date and today
    $dob = date_create_from_format('Y-m-d', $dob);
    $today = new DateTime();
    $interval = $dob->diff($today);
    $age = floatval($interval->y);
  }
  
  if($age >= 60 && !empty($seniorsCard)){
    
    // if($totals['discount'] > 0 && $_SESSION['user']['public']['maf']['main']['renew_option'] === 'f'){
    //   //$_SESSION['autoApplydiscount'] = 'no';
    //   //header('Location: /shopping-cart#1');
    //   //die();
    // }else
    if($totals['discount'] > 0 && $_SESSION['user']['public']['maf']['main']['renew_option'] === 't'){
      $cart_obj->ApplyDiscountCode('SENIORS');
      $totals = $cart_obj->CalculateTotal();
      header('Location: /quick-renew');
      die();
    }
  }
}
