<?php

require_once 'bank-class.php';

class PayWay extends Bank {
	
	function __construct(){
		parent::__construct();
	}
	
	function Submit(){
		return parent::Submit();
	}

}