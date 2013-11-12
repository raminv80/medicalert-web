<?php
class ListClass{

	protected $CONFIG_OBJ;
	protected $DBTABLE;
	//URL value passed into constructor
	private $URL;
	//SQL ELEMENTS
	protected $SELECT = "*";
	protected $TABLES = "";
	protected $WHERE = "";
	protected $ORDERBY = "";
	protected $GROUPBY = "";
	protected $LIMIT = "";
	//SET OF DATA LOADED
	protected $DATA;
	
	protected $ID;

	function __construct($_URL,$_CONFIG_OBJ){
		global $SMARTY,$DBobject;
		$this->URL = $_URL;
		$this->CONFIG_OBJ = $_CONFIG_OBJ;
		//$this->DBTABLE = new Table($this->CONFIG_OBJ->ID);
		$this->init();
	}

	/**
	 * Initialise values based on the CONFIG. This function will initialise the TABLE joins
	 */
	protected function init(){
		foreach($this->CONFIG_OBJ->table as $t){
			$_tables = $t->name;
			$tbl_comp = str_replace("tbl_","",$t->name,$count);
			$deleted_name = $tbl_comp."_deleted";
			$publish_name = $tbl_comp."_published";
			$type = $tbl_comp."_type_id";

			$this->WHERE = " {$deleted_name} IS NULL AND {$publish_name} = 1 AND {$type} = '{$this->CONFIG_OBJ->type}'  ";
			foreach($t->extends as $et){
				$f_id = str_replace("tbl_", "", $t->name);
				$s_id = str_replace("tbl_", "", $et->table);
				$_tables .= " LEFT JOIN {$et->table} ON {$t->name}.{$f_id}_id = {$et->table}.{$et->field}";

				$deleted_name = $s_id."_deleted";
				$this->WHERE .= " AND {$deleted_name} IS NULL ";
			}
			$this->WHERE .= $t->where!=''?' AND '.$t->where:'';
			$this->TABLES = $_tables;
			$count = 1;

			if(count($t->xpath('table')) > 0){
				$this->joinTable($t);
			}
		}
	}
	/**
	 * This function takes the CONFIG structure for a table which has
	 * joins. It can be called recursively. Linked tables must have a
	 * linking table named tbl_link_(parent)_(child).
	 * @param Object $table
	 */
	private function joinTable($table){
		$tbl_name = $table->name;
		$count = 1;
		$tbl_comp = str_replace("tbl_","",$tbl_name,$count);
		$id_name = $tbl_comp."_id";
		foreach($table->table as $t){
			$tbl2_name = $t->name;
			$count = 1;
			$tbl2_comp = str_replace("tbl_","",$tbl2_name,$count);
			$deleted_name = $tbl_comp."_deleted";
			$publish_name = $tbl_comp."_published";
			$id2_name = $tbl2_comp."_id";
			$this->TABLES = " LEFT JOIN tbl_link_{$tbl_comp}_{$tbl2_comp} ON $tbl_name.{$id_name} = tbl_link_{$tbl_comp}_{$tbl2_comp}.link_1_id
				LEFT JOIN $tbl2_name ON $tbl2_name.{$id2_name} = tbl_link_{$tbl_comp}_{$tbl2_comp}.link_2_id ";
			$this->WHERE = " AND {$deleted_name} IS NULL AND {$publish_name} = 1";
			if(count($t->xpath('table')) > 0){
				$this->joinTable($t);
			}
		}
	}


	function Load($_ID=null){
		global $SMARTY,$DBobject;
		$template = "";
		$data = "";
		//Split the URL
		$_url= ltrim(rtrim($this->URL,'/'),'/');

		while(true){
			if($_url == $this->CONFIG_OBJ->url && empty($_ID)){
				$data = $this->LoadTree();
				$SMARTY->assign('data', unclean($data));
				$template = $this->CONFIG_OBJ->template;
				break 1;
			}else if(!empty($_ID)){
				$bdata= $this->LoadBreadcrumb($_ID);
				$SMARTY->assign("breadcrumbs",$bdata);
				$data = $this->GetDataSingleSet($_ID);
				foreach($data[0] as $key => $val){
					$SMARTY->assign($key, unclean($val));
				}
				$template = $t->template;
				
				foreach($this->CONFIG_OBJ->table->associated as $a){
					$t_data = array();
					$pre = str_replace("tbl_","",$a->table);
					$sql = "SELECT * FROM {$a->table} WHERE {$a->field} = '{$_ID}' AND {$pre}_deleted IS NULL ";// AND article_deleted IS NULL";
					if($res = $DBobject->wrappedSqlGet($sql)){
						foreach ($res as $row) {
							$t_data[] = $row;
						}
					}
					$SMARTY->assign("{$a->name}",$t_data);
				}
				foreach($this->CONFIG_OBJ->table->extends as $a){
					$t_data = array();
					$pre = str_replace("tbl_","",$a->table);
					$sql = "SELECT * FROM {$a->table} WHERE {$a->field} = '{$_ID}' AND {$pre}_deleted IS NULL ";// AND article_deleted IS NULL";
					if($res = $DBobject->wrappedSqlGet($sql)){
						foreach($res[0] as $key => $val){
							$SMARTY->assign($key, unclean($val));
						}
					}
				}
				
				if(!empty($data)){
					break 1;
				}
			}else{
				if($template = $this->LoadTemplate($_url)){
					break 1;
				}
			}
			header("Location: /404");
			die();
		}

		return $template;
	}
	
	private function cached($type, $timestamp, $func, $p=null){
		global $DBobject;
		$data = array();
		$sql = "SELECT * FROM cache_data WHERE cache_type = :type";
		$params = array(":type"=>$type);
		if($res = $DBobject->wrappedSqlGet($sql,$params)){
			if(strtotime($res[0]['cache_modified']) == strtotime($timestamp)){
				$data = unserialize($res[0]['cache_val']);
			}else{
				$data = $this->$func($p);
				$sql = "UPDATE cache_data SET cache_val = :data, cache_modified = :mod WHERE cache_id = :id";
				$params = array(":id"=>$res[0]['cache_id'],":data"=> serialize($data),":mod"=>$timestamp);
				$DBobject->wrappedSql($sql,$params);
			}
		}else{
			$data = $this->$func($p);
			$sql = "INSERT INTO cache_data (cache_type, cache_val, cache_modified) VALUES (:type,:data,:mod)";
			$params = array(":type"=>$type,":data"=> serialize($data),":mod"=>$timestamp);
			$DBobject->wrappedSql($sql,$params);
		}
		return $data;
	}

	private function LoadTemplate($_url){
		global $SMARTY,$DBobject;
		if($id = $this->ChkCache($_url)){
			$this->Load($id);
			$p_data = $this->LoadParents($id);
			$SMARTY->assign("listing_parent",$p_data);
			$template = $this->CONFIG_OBJ->table->template;
			return $template;
		}
		return false;
	}
	
	private function LoadParents($_id){
		global $SMARTY,$DBobject;
		$data = array();
		$sql = "SELECT l.* FROM tbl_listing WHERE tbl_listing.listing_id = :id AND l.listing_published = '1' AND l.listing_deleted IS NULL ";
		$params = array(":id"=>$_id);
		if($res = $DBobject->wrappedSqlGet($sql,$params)){
			$data = $res[0];
			foreach($this->CONFIG_OBJ->table->associated as $a){
				$t_data = array();
				$pre = str_replace("tbl_","",$a->table);
				$sql = "SELECT * FROM {$a->table} WHERE {$a->field} = '{$_id}' AND {$pre}_deleted IS NULL ";// AND article_deleted IS NULL";
				if($res = $DBobject->wrappedSqlGet($sql)){
					foreach ($res as $row) {
						$t_data[] = $row;
					}
				}
				$data["{$a->name}"] = $t_data;
			}
// 			$data['listing_parent'] = $this->LoadParents($res[0]['listing_id']); 
		}
		return $data;
	}
	
	function LoadData($_ID){
		global $SMARTY,$DBobject;
		$data = $this->GetDataSingleSet($_ID);
		
		foreach($this->CONFIG_OBJ->table->associated as $a){
			$t_data = array();
			$pre = str_replace("tbl_","",$a->table);
			$sql = "SELECT * FROM {$a->table} WHERE {$a->field} = '{$_ID}' AND {$pre}_deleted IS NULL ";// AND article_deleted IS NULL";
			if($res = $DBobject->wrappedSqlGet($sql)){
				foreach ($res as $row) {
					$t_data[] = $row;
				}
			}
			$data["{$a->name}"] = $t_data;
		}
		foreach($this->CONFIG_OBJ->table->extends as $a){
			$t_data = array();
			$pre = str_replace("tbl_","",$a->table);
			$sql = "SELECT * FROM {$a->table} WHERE {$a->field} = '{$_ID}' AND {$pre}_deleted IS NULL ";// AND article_deleted IS NULL";
			if($res = $DBobject->wrappedSqlGet($sql)){
				foreach ($res as $row) {
					foreach($row as $key => $val){
						$data["{$key}"] = unclean($val);
					}
				}
			}
		}
		return $data;
	}
	
	private function ChkCache($_url){
		global $SMARTY,$DBobject;
		$args = explode('/', $_url);
		$a = end($args);
		$sql = "SELECT cache_record_id FROM cache_tbl_listing WHERE cache_url = :url";
		$params = array(":url"=>$_url);
		try{
			$row = $DBobject->wrappedSqlGetSingle($sql,$params);
			if(empty($row)){
				$sql2 = "SELECT listing_url FROM tbl_listing WHERE listing_url = :url";
				$params2 = array(":url"=>$a);
				if($res = $DBobject->wrappedSqlGet($sql2,$params2) ){
					$this->BuildCache();
					$row = $DBobject->wrappedSqlGetSingle($sql,$params);
				}
			}
		}catch(Exception $e){
			$sql2 = "SELECT listing_url FROM tbl_listing WHERE listing_url = :url";
			$params2 = array(":url"=>$a);
			if($res = $DBobject->wrappedSqlGet($sql2,$params2) ){
				$this->BuildCache();
				$row = $DBobject->wrappedSqlGetSingle($sql,$params);
			}
		}
		if(!empty($row)){
			return $row['cache_record_id'];
		}
		return false;
	}
	
	function BuildCache(){
		global $SMARTY,$DBobject;
		$sql[0] = "CREATE TABLE IF NOT EXISTS `cache_tbl_listing` (
		`cache_id` INT(11) NOT NULL AUTO_INCREMENT,
		`cache_record_id` INT(11) DEFAULT NULL,
		`cache_url` VARCHAR(255) DEFAULT NULL,
		`cache_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
		`cache_modified` DATETIME DEFAULT NULL,
		`cache_deleted` DATETIME DEFAULT NULL,
		PRIMARY KEY (`cache_id`)
		) ENGINE=MYISAM DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;";
		$DBobject->wrappedSql($sql[0]);
		
		$sql[3] = "TRUNCATE cache_tbl_listing;";
		$sql[2] = "INSERT INTO cache_tbl_listing (cache_record_id,cache_url,cache_modified) VALUES  ";
		$params = array();
		$sql[1] = "SELECT listing_id AS id FROM tbl_listing WHERE listing_published = '1' AND listing_deleted IS NULL";
		$res = $DBobject->wrappedSql($sql[1]);
		$n = 1;
		
		foreach($res as $row){
			$id = $row['id'];
			$url = "";
			if(!$this->BuildUrl($id,$url)){
				continue;
			}
	
			$sql[2].= " ( :id{$n}, :title{$n}, now() ) ,";
			$params = array_merge($params , array(":id{$n}"=>$id,":title{$n}"=>$url) );
			$n++;
		}
		$sql[2] = trim(trim($sql[2]), ',');
		$sql[2].= ";";

		$DBobject->wrappedSql($sql[3]);
		$DBobject->wrappedSql($sql[2],$params);
	}
	
	function BuildUrl($_id, &$url){
		global $DBobject;
		$sql = "SELECT tbl_listing.* FROM tbl_listing WHERE listing_id = :id";
		$params = array(":id"=>$_id);
		if($res = $DBobject->wrappedSql($sql,$params)){
			if(!empty($res[0]['listing_deleted']) || $res[0]['listing_published']!= '1'){
				return false;
			}
			if(!empty($res[0]['listing_id'])){ //category_listing_id
				$url = $res[0]['listing_url'].'/'.$url;
				return $this->BuildUrl($res[0]['listing_id'],$url); //category_listing_id
			}else{
				$url = $res[0]['listing_url'].'/'.$url;
				$url = ltrim(rtrim($url,'/'),'/');
				return true;
			}
		}else{
			return false;
		}
	}

	
	function LoadBreadcrumb($_id,$_subs=null){
		global  $CONFIG,$SMARTY,$DBobject;
		$data = array();
		$sql = "SELECT * FROM tbl_listing WHERE tbl_listing.listing_id = :id AND tbl_listing.listing_deleted IS NULL";
		$params = array(":id"=>$_id);
		if($res = $DBobject->wrappedSql($sql,$params)){
			$data[$res[0]['listing_id']]["title"]=ucfirst(unclean($res[0]['listing_title']));
			$data[$res[0]['listing_id']]["url"]=$res[0]['listing_url'];
			$data[$res[0]['listing_id']]["subs"]=$_subs;
			if(!empty($res[0]['listing_parent_id']) && $res[0]['listing_parent_id'] != 0){
				$sql2 = "SELECT * FROM tbl_listing WHERE tbl_listing.listing_id = :cid AND tbl_listing.listing_deleted IS NULL";
				$params2 = array(":cid"=>$res[0]['listing_parent_id']);
				if($res2 = $DBobject->wrappedSql($sql2,$params2)){
					$data = $this->LoadBreadcrumb($res2[0]['listing_id'],$data);
				}
			}
		}
		return $data;
	}
	
	
	function LoadMenu($_pid, $_cid=0, $level=0){
		global  $CONFIG,$SMARTY,$DBobject;
		$data = array();
	
		//GET LISTINGS AND CATEGORIES FOR THIS SECTION
		$sql = "SELECT tbl_listing.listing_id, tbl_listing.listing_title, tbl_listing.listing_url, tbl_listing.listing_name, tbl_listing.listing_parent_id, tbl_listing.listing_parent_flag FROM tbl_listing WHERE tbl_listing.listing_parent_id = :cid AND tbl_listing.listing_published = '1' AND tbl_listing.listing_display_menu = '1' AND tbl_listing.listing_deleted IS NULL ORDER BY tbl_listing.listing_order ASC";
		$params = array(":cid"=>$_cid);
		if($res = $DBobject->executeSQL($sql,$params)){
			foreach ($res as $row) {
				$t_array = array(
						"category_name"=>ucfirst(unclean($row['listing_name'])),
						"category_id"=>$row['listing_id'],
						"title"=>ucfirst(unclean($row['listing_title'])),
						"url"=>$row['listing_url'],
						"selected"=>0,
						"listings"=>0
				);
				
				if(intval($row['listing_parent_flag']) == 1){
					$t_array["category"] = 1;
					$subs = $this->LoadMenu($_pid,$row['listing_id'],$level+1);
					if($subs['selected'] == 1){
						$t_array["selected"] = 1;
						$data['selected'] = 1;
						unset($subs['selected']);
					}
					if($subs['listings'] == 1){
						$t_array["listings"] = 1;
						$data['listings'] = 1;
						unset($subs['listings']);
					}
					$t_array["subs"]=$subs;
				}else{
					$data['listings'] = 1;
				}
				
				if($row['listing_id'] == $_pid){
					$data['selected'] = 1;
					$t_array["selected"] = 1;
				}
				$data[] = $t_array;
			}
		}
		if($level==0){
			unset($data['selected']);
			unset($data['listings']);
		}
		return $data;
	}
	
	function LoadTree($_cid=0, $level=0){
		global  $CONFIG,$SMARTY,$DBobject;
		$data = array();
		
		if(!empty($this->CONFIG_OBJ->depth) && intval($this->CONFIG_OBJ->depth) > 0 && intval($this->CONFIG_OBJ->depth) <= $level){
			return $data;
		}
	
		//GET THE TOP LEVEL CATEGORY (IF ANY) WHICH THIS OBJECT IS LINKED TOO
		$order = " ORDER BY tbl_listing.listing_order ASC";
		if(!empty($this->CONFIG_OBJ->orderby)){
			$order = " ORDER BY ". $this->CONFIG_OBJ->orderby;
		}
		$extends = "";
		foreach($this->CONFIG_OBJ->table->extends as $a){
			$pre = str_replace("tbl_","",$a->table);
			$extends = " LEFT JOIN {$a->table} ON tbl_listing.listing_id = {$a->field}";// AND article_deleted IS NULL";
		}
		$sql = "SELECT * FROM tbl_listing {$extends} WHERE tbl_listing.listing_parent_id = :cid AND tbl_listing.listing_type_id = :type AND tbl_listing.listing_deleted IS NULL AND tbl_listing.listing_published = 1 ".$order;
		$params = array(":cid"=>$_cid,":type"=>$this->CONFIG_OBJ->type);
		if($res = $DBobject->wrappedSql($sql,$params)){
			foreach ($res as $row) {
				$data["{$row['listing_id']}"]=unclean($row);
				foreach($this->CONFIG_OBJ->table->associated as $a){
					if($a->attributes()->listing){
						$t_data = array();
						$pre = str_replace("tbl_","",$a->table);
						$sql = "SELECT * FROM {$a->table} WHERE {$a->field} = '{$row['listing_id']}' AND {$pre}_deleted IS NULL ";// AND article_deleted IS NULL";
						if($res2 = $DBobject->wrappedSqlGet($sql)){
							foreach ($res2 as $row2) {
								$t_data[] = $row2;
							}
						}
						$data["{$row['listing_id']}"]["{$a->name}"] = $t_data;
					}
				}
				$subs = $this->LoadTree($row['listing_id'],$level++);
				$data["{$row['listing_id']}"]['listings']=$subs;
			}
		}
		
		return $data;
	}

	/**
	 * This function retieves a set of raw data for use in templates other than the
	 * listing templates.
	 *
	 * $_WHERE should be formatted as " field = value AND field2 = value2 ".
	 * $_GROUPBY should be formatted as " field, field2 ".
	 * $_ORDERBY should be formatted as " field ASC, field2 DESC ".
	 * @param string $_WHERE
	 * @param unknown_type $_GROUPBY
	 * @param unknown_type $_ORDERBY
	 */
	function GetRawData($_WHERE="",$_GROUPBY="",$_ORDERBY=""){
		return $this->GetData("*",$_WHERE,$_GROUPBY,$_ORDERBY);
	}

	/**
	 * This function retrieves all the distinct values from $_FIELD in the database.
	 * @param string $_FIELD
	 */
	protected function GetDataField($_FIELD){
		return $this->GetData($_FIELD,"",$_FIELD,"");
	}

	/**
	 * This function retieves a SubSet of all values in the database where the $_WHERE
	 * conditions are satisfied.
	 *
	 * $_WHERE should be formatted as " field = value AND field2 = value2 ".
	 * @param string $_WHERE
	 */
	protected function GetDataSubSet($_WHERE){
		return $this->GetData("*",$_WHERE,"","");
	}

	/**
	 * This function retrieves all values in the database. The result set will be returned
	 * as ARRAY[][row1]
	 * 			 [row2]
	 * 			 etc.
	 *
	 * $GB_FIELDS can be used to define the field used to group the data at the top level
	 * in the result set.
	 * eg.	GetDataSet("month_field");
	 * ARRAY[April][row5]
	 * 			   [row6]
	 * 		[May][row7]
	 * 			 [row8]
	 * 		etc.
	 * @param string $GB_FIELD
	 */
	protected function GetDataSet($GB_FIELD=""){
		$_resSet = array();
		$res = $this->GetData("*","","","");
		if(!empty($GB_FIELD)){
			foreach($res as $row){
				$_resSet[$row[$GB_FIELD]][] = $row;
			}
			return $_resSet;
		}
		return $res;
	}

	/**
	 * This function retrieves a single value from the database based on the ID matching against
	 * the primary table.
	 * @param string $ID
	 */
	protected function GetDataSingleSet($ID){
		$count = 1;
		$id_name = str_replace("tbl_","",$this->CONFIG_OBJ->table->name,$count)."_id";
		return $this->GetData("*"," {$id_name} = {$ID} ","","");
	}

	/**
	 * This is the top level class for retrieving data from the database. Classes such
	 * as GetDataSubSet() or GetDataSet() should be used instead.
	 * @param unknown_type $_SELECT
	 * @param unknown_type $_WHERE
	 * @param unknown_type $_GROUPBY
	 * @param unknown_type $_ORDERBY
	 */
	protected function GetData($_SELECT="*",$_WHERE="",$_GROUPBY="",$_ORDERBY=""){
		global  $DBobject,$SMARTY;
		$sql = "SELECT {$_SELECT}
				FROM {$this->TABLES}
				".(!empty($_WHERE)?" WHERE {$this->WHERE} AND {$_WHERE} ":" WHERE {$this->WHERE} ")."
				".(!empty($_GROUPBY)?" GROUP BY {$_GROUPBY}":"")."
				".(!empty($_ORDERBY)?" ORDER BY {$_ORDERBY}":"")."
				".(!empty($this->LIMIT)?" LIMIT {$this->LIMIT}":"");
		//echo $sql."<br>";
		$data = $DBobject->wrappedSql($sql);
		return $data;
	}
	
}




