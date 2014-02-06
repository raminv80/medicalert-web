<?php

if(checkToken('frontend',$_POST["formToken"], true)){
	switch ($_POST["action"]) {
		case 'ADDTOCART':
			$cart_obj = new cart();
			$response = $cart_obj->AddToCart($_POST["product_id"], $_POST["attr"], $_POST["quantity"], $_POST["price"]);
			$itemsCount = $cart_obj->NumberOfProductsOnCart();
			$cart = $cart_obj->GetDataCart();
			$productsOnCart = $cart_obj->GetDataProductsOnCart();
			$SMARTY->assign('productsOnCart',$productsOnCart);
			$popoverShopCart= $SMARTY->fetch('templates/popover-shopping-cart.tpl');
			
			echo json_encode(array(
		    				"message" => $response,
		    				"itemsCount" => $itemsCount,
		    				"subtotal" => $cart['cart_subtotal'],
							"popoverShopCart" =>  str_replace(array("\r\n", "\r", "\n", "\t"), ' ', $popoverShopCart)
	    				));
		    exit;
		    
	    case 'DeleteItem':
	    	$cart_obj = new cart();
	    	$response = $cart_obj->RemoveFromCart($_POST["cartitem_id"]);
            $totals = $cart_obj->CalculateTotal();
            $itemsCount = $cart_obj->NumberOfProductsOnCart();
            $productsOnCart = $cart_obj->GetDataProductsOnCart();
            $SMARTY->assign('productsOnCart',$productsOnCart);
            $popoverShopCart= $SMARTY->fetch('templates/popover-shopping-cart.tpl');
	    	echo json_encode(array(
	    					"itemsCount" => $itemsCount,
                            "response"=> $response,
                            "totals"=>$totals,
							"popoverShopCart" =>  str_replace(array("\r\n", "\r", "\n", "\t"), ' ', $popoverShopCart)
            ));
	    	exit;

    	case 'updateCart':
    		$cart_obj = new cart();
    		$subtotals = $cart_obj->UpdateQtyCart($_POST["qty"]);
    		$totals = $cart_obj->CalculateTotal();
            $itemsCount = $cart_obj->NumberOfProductsOnCart();
            $productsOnCart = $cart_obj->GetDataProductsOnCart();
            $SMARTY->assign('productsOnCart',$productsOnCart);
            $popoverShopCart= $SMARTY->fetch('templates/popover-shopping-cart.tpl');
    		echo json_encode(array(
		    		"itemsCount"=> $itemsCount,
    				"subtotals"=>$subtotals,
    				"totals"=>$totals,
					"popoverShopCart" =>  str_replace(array("\r\n", "\r", "\n", "\t"), ' ', $popoverShopCart)
    		));
    		exit;
    		
		case 'applyDiscount':
		    $cart_obj = new cart();
		    $res = $cart_obj->ApplyDiscountCode($_POST["discount_code"]);
		    if ($res['error']) {
		    	$_SESSION['error']= $res['error'];
		    	$_SESSION['post']= $_POST;
		    	header("Location: ".$_SERVER['HTTP_REFERER']."#error");
		    } else {
		    	header("Location: ".$_SERVER['HTTP_REFERER']);
		    }
		    exit;
		    
		case 'placeOrder':
    		
    		$user_obj = new UserClass();
    		$billID = $user_obj->InsertNewAddress($_POST["address"][1]);
    		$shipID = $billID;
    		if (is_null($_POST['same_address'])) { 
    			$shipID = $user_obj->InsertNewAddress($_POST["address"][2]);
    		}
    		
    		if ($billID && $shipID) {
    			$pay_obj = new PayWay();
	    		//TODO: INITIALISE BANK PAYMENT
    			$response = false;
    			$error_msg = null;
    			
	    		try{
	    			//TODO: SUBMIT PAYMENT
	    			$reponse = $pay_obj->Submit();	
	    			
	    		}catch(Exception $e){
	    			$error_msg = 'Payment failed: Connection Error. ';
	    		}
	    		
	    		$params = array_merge(array(
	    				"payment_billing_address_id" => $billID,
	    				"payment_shipping_address_id" => $shipID,
	    				"payment_status" => 'P',
	    		),
	    				$_POST["payment"]
	    		);
	    		$pay_obj->StorePaymentRecord($params);
	    		
	    		if ($reponse){
	    			// PAYMENT SUCCESS
	    			$cart_obj = new cart();
	    			$cart_obj->CloseCart();
	    			$cart_obj->CreateCart($_SESSION['user']['id']);
	    			header("Location: /thank-you-for-buying");
	    			exit;
	    			
	    		} else {
	    			if ($error_msg) {
	    				$_SESSION['error'] = $error_msg;
	    			} else {
	    				$_SESSION['error'] = 'Payment failed. Verify information and try again. ';
	    			}
	    		}
    		} else {
    			$_SESSION['error']= 'Database Connection Error. Please try again, otherwise contact us by phone.';
    		}
    		
    		$_SESSION['post']= $_POST;
    		header("Location: ".$_SERVER['HTTP_REFERER']."#error");
    		
    		exit;


	}
}else{
	die('');
}