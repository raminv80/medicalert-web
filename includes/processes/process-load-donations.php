<?php
global $SMARTY, $DBobject, $CONFIG, $GA_ID;

// Donations object id
$productObjId = 217; 

$products = array();
try{
  $sql = "SELECT * FROM tbl_product 
  WHERE (product_deleted IS NULL OR product_deleted = '0000-00-00') 
  AND product_published = 1 AND product_object_id = :id";
  if($res = $DBobject->wrappedSql($sql, array(":id" => $productObjId))){
    $products = $res[0];
    $sql = "SELECT tbl_variant.*, productattr_attribute_id AS 'attribute_id', productattr_attr_value_id AS 'attr_value_id' 
    FROM tbl_variant LEFT JOIN tbl_productattr ON productattr_variant_id = variant_id 
    WHERE (variant_deleted IS NULL OR variant_deleted = '0000-00-00') 
    AND variant_published = 1 
    AND (productattr_deleted IS NULL OR productattr_deleted = '0000-00-00') 
    AND variant_product_id = :id GROUP BY variant_id ORDER BY variant_order LIMIT 4";
    if($res2 = $DBobject->wrappedSql($sql, array(":id" => $res[0]['product_id']))){
      $products['variants'] = $res2;
    }
  }
  $SMARTY->assign('products', $products);
  
}catch(exceptionCart $e) {
  $SMARTY->assign('error', $e->getMessage());
}

  
