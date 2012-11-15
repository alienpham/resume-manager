<?php
class Vacancy_Model_VacancyMapper {
	protected $_dbTable;
	var $htmlstr;
    public function setDbTable ($dbTable)
    {
        if (is_string($dbTable)) {
            $dbTable = new $dbTable();
        }
        if (! $dbTable instanceof Zend_Db_Table_Abstract) {
            throw new Exception('Invalid table data gateway provided');
        }
        $this->_dbTable = $dbTable;
        return $this;
    }
    public function getDbTable ()
    {
        if (null === $this->_dbTable) {
            $this->setDbTable('Vacancy_Model_DbTable_Vacancy');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Vacancy_Model_Vacancy $vacancy)
    {
        $data = array(
			'company_id' 		=> $vacancy->getCompanyId(), 
			'vacancy_code' 		=> $vacancy->getVacancyCode(), 
			'no_of_vacancies' 	=> $vacancy->getNoOfVacancies(),
        	'job_title' 		=> $vacancy->getJobTitle(), 
			'min_salary' 		=> $vacancy->getMinSalary(),
        	'max_salary' 		=> $vacancy->getMaxSalary(), 
			'estimated_salary' 	=> $vacancy->getEstimatedSalary(), 
        	'work_level_id' 	=> $vacancy->getWorkLevelId(), 
			'public' 			=> $vacancy->getPublic(), 
			'status' 			=> $vacancy->getStatus(),
        	'created_date' 		=> $vacancy->getCreatedDate(), 
			'updated_date' 		=> $vacancy->getUpdatedDate()
		);
		
    	if (null == ($id = $vacancy->getVacancyId())) {
            return $this->getDbTable()->insert($data);
        } else {
        	$this->getDbTable()->update($data, array('vacancy_id = ?' => $id));
            return $id;
        }
    }
    
	public function getListVacancy ($where = null, $orderby = null, $offset="", $limit="")
    {
    	$db = $this->getDbTable()->getAdapter();
    	if ($limit=="")
       		$sql = "SELECT * FROM vacancy WHERE $where ORDER BY $orderby";
       	else 
       		$sql = "SELECT * FROM vacancy WHERE $where ORDER BY $orderby LIMIT $offset,$limit";
        $result = $db->fetchAll($sql);
        
        return $result;
    }
    
	public function getSalaryValue($min,$max)
	{
		if($min==$max && $max>0)
				$salary="Around $".number_format($max,2,'.',',');
		else
		if($min==$max && ($max==0 || $max==""))
			$salary="Negotiable";
		else
		if($min>0 && ($max==0|| $max==""))
			$salary="Above $".number_format($min,2,'.',',');
		else			
		if(($min==0 || $min=="") && $max>0 )
			$salary="Up to $".number_format($max,2,'.',',');
		else
			$salary="$".number_format($min,2,'.',','). "-$".number_format($max,2,'.',',');
		return str_replace(".00","",$salary);
	}
	
	public function countOpenVacancy()
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT count(*) as numopen FROM vacancy WHERE status= 'Open'";
    	$result = $db->fetchAll($sql);
    	return $result[0]['numopen'];
    }
    
	public function countPublicVacancy()
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT count(*) as numopen FROM vacancy WHERE public= 'Yes'";
    	$result = $db->fetchAll($sql);
    	return $result[0]['numopen'];
    }
    
	public function countConfidentialVacancy()
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT count(*) as numopen FROM vacancy WHERE public= 'No'";
    	$result = $db->fetchAll($sql);
    	return $result[0]['numopen'];
    }
    
	public function getListRecord($class_name,$condition,$field,$from=null,$to=null){
		$db = $this->getDbTable()->getAdapter();
		if ($from=="")
       		$sql = "SELECT * FROM $class_name WHERE $condition ORDER BY $field";
       	else 
       		$sql = "SELECT * FROM $class_name WHERE $condition ORDER BY $field LIMIT $from,$to";
        $result = $db->fetchAll($sql);
        
        return $result;
	}
    
	function getListMultiFunctionLookup($section_id,$checkboxname="cbTargetFunction", $textfieldname="targetFunction", $hiddenId="hdFunctionLookup", $vlhdFunctionLookup='',$condition=1)
	{
		$listFunctionLookup=$this->getListRecord("function_lookup",$condition,"sort_order");
		$targetFunctionTree = new Vacancy_Model_TreeCheckBox($section_id);
		$targetFunctionTree->addNode("",0,1);
		$itemOnCol = ceil(count($listFunctionLookup)/3);
		$loop = 0;
		$arr=explode(',',$vlhdFunctionLookup);
		foreach ($listFunctionLookup as $functionLookup){
			$checked = "";
			for($j=0;$j<count($arr);$j++)
			if (trim($arr[$j])==$functionLookup['function_id'])
			$checked="checked";
			if(	$loop == $itemOnCol){
				$targetFunctionTree->endtree();
				$targetFunctionTree->showtree();
				$targetFunctionTree->addNode("",0,1);
				$itemOnCol = $itemOnCol * 2;
			}
			if($functionLookup['parent_function_id'] == 0){
				if($loop == $itemOnCol - 1 ){
					$targetFunctionTree->endtree();
					$targetFunctionTree->showtree();
					$targetFunctionTree->addNode("",0,1);
					$itemOnCol = $itemOnCol * 2;
				}
				$targetFunctionTree->addNodeParent($functionLookup['name'], $loop);
			}else{
				$targetFunctionTree->addItem($functionLookup['function_id'], $functionLookup['name'], $checkboxname, $textfieldname, $hiddenId, $checked);
			}
			$loop++;
		}
		$targetFunctionTree->endtree();
		return $targetFunctionTree->showTree();
	}
	
	function getListMultiProvinceLookup($section_id,$checkboxname="cbTargetProvince", $textfieldname="targetProvince", $hiddenId="hdProvinceLookup",$vlhdProvinceLookup='',$condition=1)
	{
		$listProvinceLookup=$this->getListRecord("province_lookup",$condition,"sort_order");
		$targetProvinceTree = new Vacancy_Model_TreeCheckBox($section_id);
		$targetProvinceTree->addNode("",0,1);
		$itemOnCol = ceil(count($listProvinceLookup)/3);
		$loop = 0;
		$arr=explode(',',$vlhdProvinceLookup);
		foreach ($listProvinceLookup as $provinceLookup){
			$checked = "";
			for($j=0;$j<count($arr);$j++)
				if (trim($arr[$j])==$provinceLookup['province_id'])
					$checked="checked";
			if(	$loop == $itemOnCol){
				$targetProvinceTree->endtree();
				$targetProvinceTree->showtree();
				$targetProvinceTree->addNode("",0,1);
				$itemOnCol = $itemOnCol * 2;
			}
			$targetProvinceTree->addItem($provinceLookup['province_id'], $provinceLookup['name'], $checkboxname, $textfieldname, $hiddenId, $checked);
			$loop++;
		}
		$targetProvinceTree->endtree();
		return $targetProvinceTree->showTree();
	}
	
	public function updateStatus($listId,$status) {
		$db = $this->getDbTable()->getAdapter();
		if ($listId=="")
			$listId="''";
        $sql = 'UPDATE vacancy SET status = "'. $status .'", updated_date = '. date('Y-m-d H:i:s') ." WHERE vacancy_id IN($listId)";
        $db->query($sql);
	}
}
